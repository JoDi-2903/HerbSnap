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
                        
                        Text("The app 'Swidget' was developed to present the WidgetKit and its functionalities as an example. The aim of the project is not to create an AppStore-ready application, but to present the framework in a demo. As content for the widgets and general theme movies were chosen, which are provided by the open 'The Movie Database' (TMDB) API. This app contains four pages and seven widgets, divided into three widget groups.")
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
                    Text(Locale.preferredLanguages[0])
                }
                Section {
                    let year = Calendar(identifier: .gregorian).component(.year, from: Date())
                    
                    Text("Legal notice")
                        .font(.headline)
                        .bold()
                        .padding(.all, 5)
                    Text("This app was created as part of the student research thesis at DHBW Stuttgart.")
                    Text("Copyright by Jonathan Diebel" + " " + String(year))
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
