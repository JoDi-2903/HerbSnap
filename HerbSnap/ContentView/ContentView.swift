//
//  ContentView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 09.12.22.
//

import SwiftUI

struct ContentView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var flashlightOn = false
    
    let cameraService = CameraService()
    
    var body: some View {
        ZStack {
            // Show live camera feed
            CameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                        print("Image captured successfully.")
                    } else {
                        print("Error: No image data found.")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    // Button for turning flashlight on/off
                    Button(action: { flashlightOn = toggleFlashlight(flashlightOn: flashlightOn)}) {
                        flashlightOn ? Image(systemName: "bolt.fill") : Image(systemName: "bolt.slash.fill")
                    }
                }
            }
            .padding(.top)
            
            VStack {
                Spacer()
                // Button for capturing the photo
                Button(action: {
                    cameraService.capturePhoto()
                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                })
                .padding(.bottom)
            }
        }
    }
}
