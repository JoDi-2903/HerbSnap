//
//  InformationView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 30.12.22.
//

import SwiftUI

struct InformationView: View {
    @Binding var activeView: Int
    
    @State private var toast: FancyToast? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .frame(width: 100.0, height: 100.0)
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                        
                        Spacer(minLength: 5)
                        
                        Text("HerbSnap is an app for classifying herbs based on photos of the plant. As input data, a photo can either be taken directly via the app or an existing image from the gallery can be opened. The app processes the data on the device and uses artificial intelligence to determine the herb species. Two different prediction models are available, which can be switched between using the button in the upper right corner. One model was generated with CreateML from Apple and the other with TensorFlow from Google. As result, the detected herb species is output, with a direct link to the Wikipedia page for more information. If the prediction of the model is not completely clear, the two most probable prediction classes are output.")
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.all, 10)
                }
                Section {
                    Text("Photo tips")
                        .font(.headline)
                        .bold()
                        .padding(.all, 5)
                    //.padding(.bottom, 10)
                    VStack {
                        Image("PhotoTips_1")
                            .resizable()
                            .scaledToFit()
                        HStack(alignment: .center) {
                            VStack {
                                Image("PhotoTips_2_1")
                                    .resizable()
                                    .scaledToFit()
                                Text("too close")
                            }
                            Spacer()
                            VStack {
                                Image("PhotoTips_2_2")
                                    .resizable()
                                    .scaledToFit()
                                
                                Text("too far")
                            }
                            Spacer()
                            VStack {
                                Image("PhotoTips_2_3")
                                    .resizable()
                                    .scaledToFit()
                                
                                Text("several types")
                            }
                        }
                    }
                }
                Section {
                    let year = Calendar(identifier: .gregorian).component(.year, from: Date())
                    
                    Text("Legal notice")
                        .font(.headline)
                        .bold()
                        .padding(.all, 5)
                    VStack(alignment: .leading) {
                        Text("This app was created as part of the student research thesis at DHBW Stuttgart.")
                        Text("Copyright by Jonathan Diebel" + " " + String(year))
                    }
                }
            }
            .navigationTitle("HerbSnap")
            .navigationBarItems(leading: Button(action : {activeView = 1}){
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }
            })
        }
    }
}
