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
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch activeView {
                case 1:
                    CaptureView(activeView: $activeView, capturedImage: $capturedImage)
                case 2:
                    ResultsView(activeView: $activeView, capturedImage: $capturedImage)
                case 3:
                    InformationView(activeView: $activeView)
                default:
                    // Error: Invalid view called. Back to default CaptureView.
                    CaptureView(activeView: $activeView, capturedImage: $capturedImage)
                }
                
                // Transparent color for the top safeArea
                GeometryReader { reader in
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .opacity(0.6)
                        .ignoresSafeArea(edges: .top)
                }
            }
        }
    }
}
