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
        VStack {
            Button {
                toast = FancyToast(herbName: "Basil", binomialName: "Lorem ipsum", herbImageName: "Basil")
            } label: {
                Text("Run")
            }
            
        }
        .toastView(toast: $toast)
        
    }
}

