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
    @State private var toast: FancyToast? = nil
    
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
                    Button(action: {
                        activeView = 1
                    }) {
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
                .padding(.top, 18)
                .padding(.horizontal, 33)
                .overlay(AppLogoOverlay, alignment: .center)
                
                Spacer()
                
                // Area for FancyToast to appear
                HStack {}
                .toastView(toast: $toast)
                .padding(.horizontal, 17)
            }
        }
        .onAppear {
            self.classificationLabel = performImageClassification(img: capturedImage!)
            toast = FancyToast(herbName: [classificationLabel, "Toast2"], binomialName: ["Lorem ipsum", "Lala"], herbImageName: ["Basil", "Basil"], doubleToast: true)
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
