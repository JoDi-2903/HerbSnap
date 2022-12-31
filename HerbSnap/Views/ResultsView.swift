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
            let uiImage = capturedImage?.resizeTo(size: CGSize(width: 1080, height: 1920))
            // Show captured image
            Image(uiImage: uiImage!)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    // Button for going back to CaptureView
                    Button(action: { activeView = 1 }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    // Button for app information and about page
                    Button(action: { activeView = 3 }) {
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
                    .padding()
            }
        }
        .task {
            performClassificationAndOutputToast()
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
    
    private func performClassificationAndOutputToast() -> () {
        // Call classification method and split the two return parameters
        let classificationResult = performImageClassification(img: capturedImage!, model: useCreateMLModel)
        self.classificationLabel = classificationResult.0
        self.classificationLabelProps = classificationResult.1
        
        // Sort and output results of the classification
        let classLabelPropsSorted = self.classificationLabelProps.sorted { return $0.value > $1.value }
        print("Classification results sorted: \(classLabelPropsSorted)")
        
        // Initialize parameters passed to the toast method
        var herbName: [String] = []
        var binomialName: [String] = []
        var herbImageName: [String] = []
        var doubleToast: Bool = false
        
        // Use the probabilities to check whether the result is clear or not
        if (classLabelPropsSorted[0].value - classLabelPropsSorted[1].value) <= 0.2 {
            if Locale.preferredLanguages[0].prefix(2) == "de" {
                herbName.append(contentsOf: [classLabelPropsSorted[0].key.localized, classLabelPropsSorted[1].key.localized])
            } else {
                herbName.append(contentsOf: [classLabelPropsSorted[0].key, classLabelPropsSorted[1].key])
            }
            binomialName.append(contentsOf: [binomialHerbName[classLabelPropsSorted[0].key] ?? "n/a", binomialHerbName[classLabelPropsSorted[1].key] ?? "n/a"])
            herbImageName.append(contentsOf: [classLabelPropsSorted[0].key, classLabelPropsSorted[1].key])
            doubleToast = true
        } else {
            if Locale.preferredLanguages[0].prefix(2) == "de" {
                herbName.append(classLabelPropsSorted[0].key.localized)
            } else {
                herbName.append(classLabelPropsSorted[0].key)
            }
            binomialName.append(binomialHerbName[classLabelPropsSorted[0].key] ?? "n/a")
            herbImageName.append(classLabelPropsSorted[0].key)
            doubleToast = false
        }
        
        // Show FancyToast with result(s) after all parameters are set
        toast = FancyToast(herbName: herbName, binomialName: binomialName, herbImageName: herbImageName, doubleToast: doubleToast)
    }
}
