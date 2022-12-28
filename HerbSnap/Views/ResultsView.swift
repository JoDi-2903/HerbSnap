//
//  ResultsView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 28.12.22.
//

import SwiftUI
import PhotosUI

struct ResultsView: View {
    @Binding var activeView: Int
    @Binding var capturedImage: UIImage?
    
    var body: some View {
        ZStack {
            // Show live camera feed
            Image(uiImage: capturedImage!)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    // Button for going back to CaptureView
                    Button(action: {activeView = 1}) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Button for app information and about page
                    Button(action: {activeView = 3}) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .overlay(AppLogoOverlay, alignment: .center)
                
                Spacer()
            }
        }
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
