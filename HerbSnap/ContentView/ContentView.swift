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
                HStack {
                    // Button for changing between the two ML models
                    // Button for turning flashlight on/off
                    Button(action: { flashlightOn = toggleFlashlight(flashlightOn: flashlightOn)}) {
                        if flashlightOn == true {
                            Image(systemName: "c.square")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "t.square")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Button for turning flashlight on/off
                    Button(action: { flashlightOn = toggleFlashlight(flashlightOn: flashlightOn)}) {
                        if flashlightOn == true {
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "bolt.slash.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        Image(systemName: "leaf.fill")
                        Text("HerbSnap")
                    }
                        .font(.system(size: 20))
                        .foregroundColor(.accentColor)
                        .padding(.vertical)
                    
                    Spacer()
                    
                    // Button for app information and about
                    Button(action: { flashlightOn = toggleFlashlight(flashlightOn: flashlightOn)}) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top)
                .padding(.horizontal)

                Spacer()
                
                // Button for capturing the photo
                Button(action: {
                    cameraService.capturePhoto()
                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.95))
                        .clipShape(Circle())
                })
                .padding(.bottom, 37)
            }
        }
    }
}
