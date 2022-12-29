//
//  ResultsView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 28.12.22.
//

import SwiftUI
import CoreML

struct ResultsView: View {
    @Binding var activeView: Int
    @Binding var capturedImage: UIImage?
    
    @State private var classificationLabel: String = ""
    
    var body: some View {
        ZStack {
            // Show live camera feed
            Image(uiImage: capturedImage!)
                .resizable()
                .scaledToFill()
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
                .padding(.top, 18) //18
                .padding(.horizontal, 33) //33
                .overlay(AppLogoOverlay, alignment: .center)
                
                Spacer()
                
                Text(classificationLabel)
                    .padding()
                    .font(.title)
                    .foregroundColor(.accentColor)
            }
        }
        .onAppear {
            self.classificationLabel = performImageClassification(img: capturedImage!)
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
