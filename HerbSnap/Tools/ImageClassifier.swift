//
//  ImageClassifier.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 29.12.22.
//

import Foundation
import CoreML
import UIKit

// CreateML model
let modelCreateML: HerbsClassifier_CreateML = {
    do {
        let config = MLModelConfiguration()
        return try HerbsClassifier_CreateML(configuration: config)
    } catch {
        print(error)
        fatalError("Couldn't create CreateML model")
    }
}()

// TensorFlow model
let modelTensorFlow: HerbsClassifier_TensorFlow = {
    do {
        let config = MLModelConfiguration()
        return try HerbsClassifier_TensorFlow(configuration: config)
    } catch {
        print(error)
        fatalError("Couldn't create TensorFlow model")
    }
}()

func performImageClassification(img: UIImage, model: Bool) -> (String, Dictionary<String, Double>) {
    var classLabel: String = ""
    var classLabelProps = Dictionary<String, Double>()
    var inputSize: CGSize
    
    // Define input sizes for the two models
    // For a fairer comparison, both models were trained on the same input image size
    inputSize = CGSize(width: 299, height: 299)
    
    // Resize image to the specified input size of the model and create buffer
    guard let reizedImage = img.cropAndResizeTo(size: inputSize),
          let buffer = reizedImage.toBuffer() else {
        print("Error while resizing image and creating buffer")
        return ("", [:])
    }
    
    // Make prediction
    if model == true {
        // CreateML model
        let output = try? modelCreateML.prediction(image: buffer)
        // Unwrap output
        if let output = output {
            classLabel = output.classLabel
            classLabelProps = output.classLabelProbs
        }
    } else {
        // TensorFlow model
        let output = try? modelTensorFlow.prediction(image: buffer)
        // Unwrap output
        if let output = output {
            classLabel = output.classLabel
            classLabelProps = output.classLabelProbs
        }
    }
    
    return (classLabel, classLabelProps)
}
