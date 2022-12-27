//
//  Flashlight.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 27.12.22.
//

import Foundation
import AVFoundation

func toggleFlashlight(flashlightOn: Bool) -> Bool {
    let device = AVCaptureDevice.default(for: .video)
    var newFlashlightState: Bool = false
    
    if let device = device, device.hasTorch {
        do {
            try device.lockForConfiguration()
            
            if flashlightOn == true {
                device.torchMode = .off
                newFlashlightState = false
                print("Turned flashlight off")
            } else {
                device.torchMode = .on
                newFlashlightState = true
                print("Turned flashlight on")
            }
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    return newFlashlightState
}
