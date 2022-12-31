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
    @Binding var useCreateMLModel: Bool
    
    @State private var classificationLabel: String = ""
    @State private var classificationLabelProps = Dictionary<String, Double>()
    @State private var toast: FancyToast? = nil
    
    var body: some View {
        ZStack {
            // Show captured photo
//            let editedImage = capturedImage?.resizeTo(size: CGSize(width: 299, height: 299))
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
            let classificationResult = performImageClassification(img: capturedImage!)
            self.classificationLabel = classificationResult.0
            self.classificationLabelProps = classificationResult.1
            
            let classLabelPropsSorted = self.classificationLabelProps.sorted { return $0.value > $1.value }
            print(classLabelPropsSorted)
            print(classLabelPropsSorted[0])
            print(classLabelPropsSorted[1].key)
            
            var herbName: [String] = []
            var binomialName: [String] = []
            var herbImageName: [String] = []
            var doubleToast: Bool = false

            // Use the probabilities to check whether the result is clear or not
            if (classLabelPropsSorted[0].value - classLabelPropsSorted[1].value) <= 0.2 {
                herbName.append(contentsOf: [classLabelPropsSorted[0].key, classLabelPropsSorted[1].key])
                binomialName.append(contentsOf: [binomialHerbName[classLabelPropsSorted[0].key] ?? "n/a", binomialHerbName[classLabelPropsSorted[1].key] ?? "n/a"])
                herbImageName.append(contentsOf: [classLabelPropsSorted[0].key, classLabelPropsSorted[1].key])
                doubleToast = true
            } else {
                herbName.append(classLabelPropsSorted[0].key)
                binomialName.append(binomialHerbName[classLabelPropsSorted[0].key] ?? "n/a")
                herbImageName.append(classLabelPropsSorted[0].key)
                doubleToast = false
            }

            // Show FancyToast with result(s) after all parameters are set
            toast = FancyToast(herbName: herbName, binomialName: binomialName, herbImageName: herbImageName, doubleToast: doubleToast)
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
