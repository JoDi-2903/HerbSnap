//
//  ContentView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 09.12.22.
//

import SwiftUI

struct ContentView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, HerbSnap")
        }
        .padding()
    }
}
