//
//  HerbSnapApp.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 09.12.22.
//

import SwiftUI

@main
struct HerbSnapApp: App {
    @State var activeView = 1
    @State var capturedImage: UIImage? = nil
    @State var useCreateMLModel = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch activeView {
                case 1:
                    CaptureView(activeView: $activeView, capturedImage: $capturedImage, useCreateMLModel: $useCreateMLModel)
                case 2:
                    ResultsView(activeView: $activeView, capturedImage: $capturedImage, useCreateMLModel: $useCreateMLModel)
                case 3:
                    InformationView(activeView: $activeView)
                default:
                    // Error: Invalid view called. Back to default CaptureView.
                    CaptureView(activeView: $activeView, capturedImage: $capturedImage, useCreateMLModel: $useCreateMLModel)
                }
                
                // Transparent color for the top safeArea
                if activeView == 1 || activeView == 2 {
                    GeometryReader { reader in
                        Color(red: 0.1, green: 0.1, blue: 0.1)
                            .frame(height: reader.safeAreaInsets.top, alignment: .top)
                            .opacity(0.6)
                            .ignoresSafeArea(edges: .top)
                    }
                    .preferredColorScheme(.dark)
                }
            }
        }
    }
}
