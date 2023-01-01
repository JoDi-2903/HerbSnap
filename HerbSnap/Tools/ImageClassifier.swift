//
//  ImageClassifier.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 29.12.22.
//

import Foundation
import CoreML
import UIKit

let modelCreateML: HerbsClassifier_7_2022_12_30 = {
    do {
        let config = MLModelConfiguration()
        return try HerbsClassifier_7_2022_12_30(configuration: config)
    } catch {
        print(error)
        fatalError("Couldn't create HerbsClassifier_7_2022_10_09")
    }
}()

func performImageClassification(img: UIImage, model: Bool) -> (String, Dictionary<String, Double>) {
    var classLabel: String = ""
    var classLabelProps = Dictionary<String, Double>()
    
    // Resize image to the specified input size of the model and create buffer
    guard let reizedImage = img.cropAndResizeTo(size: CGSize(width: 299, height: 299)),
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
    }
    
    return (classLabel, classLabelProps)
}
