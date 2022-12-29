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

func performImageClassification(img: UIImage) -> String {
    var classLabel: String = ""
    
    // Resize image to the specified input size of the model and create buffer
    guard let reizedImage = img.resizeTo(size: CGSize(width: 299, height: 299)),
          let buffer = reizedImage.toBuffer() else {
        print("Error while resizing image and creating buffer")
        return ""
    }
    
    // Make prediction
    let output = try? modelCreateML.prediction(image: buffer)
    
    // Unwrap output
    if let output = output {
        classLabel = output.classLabel
        return classLabel
    }
    
    return classLabel
}
