//
//  ContentView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 09.12.22.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var selectedItems: [PhotosPickerItem] = []
    //    @State private var selectedImageData: Data? = nil
    @State private var flashlightOn = false
    @State private var useCreateMLModel = true
    @State private var showViewfinder = true
    @State private var viewfinderFocused = false
    
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
            .ignoresSafeArea(edges: .top)
            
            VStack {
                HStack {
                    // Button for changing between the two ML models
                    // Button for turning flashlight on/off
                    Button(action: {useCreateMLModel.toggle()}) {
                        if useCreateMLModel == true {
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
                    
                    // Button for app information and about page
                    Button(action: {}) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .overlay(AppLogoOverlay, alignment: .center)
                
                // Show Viewfinder Rectangle
                if showViewfinder == true {
                    HStack(alignment: .center) {
                        Image(viewfinderFocused ? "ViewFinderRectangle_Green" : "ViewFinderRectangle_White")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.8)
                    }
                    .padding(.top, 85)
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                
                HStack {
                    // Button for opening photo from library via the new PhotosPicker (iOS 16)
                    PhotosPicker(selection: $selectedItems,
                                 maxSelectionCount: 1,
                                 matching: .all(of: [.images, .not(.panoramas), .not(.bursts)])) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 23))
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.95))
                            .clipShape(Circle())
                    }
                    .onChange(of: selectedItems) { newValue in
                        guard let item = selectedItems.first else {
                            return
                        }
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    //                                    self.selectedImageData = data
                                    capturedImage = UIImage(data: data)
                                    print("Image opened successfully.")
                                } else {
                                    print("Error while opening image from library: Data is nil")
                                }
                            case .failure(let failure):
                                fatalError("Error while opening image from library: \(failure)")
                            }
                        }
                    }
                    .padding(.bottom, 39)
                    .padding(.leading, 25)
                    Spacer()
                }
                .overlay(ShutterButtonOverlay, alignment: .center)
            }
        }
    }
    
    // Button for capturing the photo
    private var ShutterButtonOverlay: some View {
        Button(action: {
            cameraService.capturePhoto()
        }, label: {
            Image(systemName: "circle")
                .font(.system(size: 72))
                .foregroundColor(.black)
                .background(Color.white.opacity(0.95))
                .clipShape(Circle())
        })
        .padding(.bottom, 39)
    }
    
    // Overlay for the AppLogo
    private var AppLogoOverlay: some View {
        HStack {
            Image(systemName: "leaf.fill")
            Text("Herb**Snap**")
        }
        .font(.system(size: 20))
        .foregroundColor(.accentColor)
    }
}
