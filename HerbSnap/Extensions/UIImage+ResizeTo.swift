//
//  UIImage+ResizeTo.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 29.12.22.
//  Credits to Advanced Swift ("Crop UIImage In Swift")
//  Source: https://www.advancedswift.com/crop-image/
//

import Foundation
import UIKit

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        // Parameters for the center crop (shortest side)
        let sideLength = min(
            self.size.width,
            self.size.height
        )

        // Determines the x,y coordinate of a centered sideLength by sideLength square
        let sourceSize = self.size
        print("w:\(sourceSize.width) x h:\(sourceSize.height); sideLength:\(sideLength)")
        let xOffset = abs(sourceSize.height - sourceSize.width) / 3.0
        let yOffset = abs(sideLength) / 10.0

        // The cropRect is the rect of the image to keep, in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral
        
        // Crop image
        let sourceCGImage = self.cgImage!
        let croppedCGImage = sourceCGImage.cropping(to: cropRect)!
        let croppedUIImage = UIImage(
            cgImage: croppedCGImage,
            scale: self.imageRendererFormat.scale,
            orientation: self.imageOrientation
        )
        
        // Resize image
        croppedUIImage.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
