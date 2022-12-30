//
//  ImageClassifier.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 29.12.22.
//

import Foundation
import CoreML
import UIKit

let modelCreateML: HerbsClassifier_7_2022_10_09 = {
    do {
        let config = MLModelConfiguration()
        return try HerbsClassifier_7_2022_10_09(configuration: config)
    } catch {
        print(error)
        fatalError("Couldn't create HerbsClassifier_7_2022_10_09")
    }
}()

func performImageClassification(img: UIImage) -> (String, Dictionary<String, Double>) {
    var classLabel: String = ""
    var classLabelProps = Dictionary<String, Double>()
    
    // Resize image to the specified input size of the model and create buffer
    guard let reizedImage = img.resizeTo(size: CGSize(width: 299, height: 299)),
          let buffer = reizedImage.toBuffer() else {
        print("Error while resizing image and creating buffer")
        return ("", [:])
    }
    
    // Make prediction
    let output = try? modelCreateML.prediction(image: buffer)
    
    // Unwrap output
    if let output = output {
        classLabel = output.classLabel
        classLabelProps = output.classLabelProbs
        
//        let classLabelPropsSorted = output.classLabelProbs.sorted { return $0.value > $1.value }
//        let classLabelPropsString = classLabelPropsSorted.map { (key, value) in
//            return ("\(key) = \(value * 100)%")
//        }
//            .joined(separator: "\n")
//        print (classLabelPropsSorted)
    }
    
    return (classLabel, classLabelProps)
}

// Dictionary for translating the herb names to binomial name
let binomialHerbName = ["Basil": "Ocimum basilicum"]
