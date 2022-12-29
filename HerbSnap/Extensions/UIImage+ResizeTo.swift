//
//  UIImage+ResizeTo.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 29.12.22.
//  Credits to Mohammad Azam ("Machine Learning and Artificial Intelligence Using Swift")
//  Source: https://www.udemy.com/course/machine-learning-and-artificial-intelligence-using-swift
//

import Foundation
import UIKit

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
