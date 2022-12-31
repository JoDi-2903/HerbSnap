//
//  FancyToastView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 30.12.22.
//  Credits to Farhan Adji ("Create a Fancy Toast Component Using SwiftUI")
//  Source: https://betterprogramming.pub/swiftui-create-a-fancy-toast-component-in-10-minutes-e6bae6021984
//

import SwiftUI

struct FancyToastView: View {
    @State private var showSafari: Bool = false
    
    var herbName: String
    var binomialName: String
    var herbImageName: String
//    var onLabelTapped: (() -> Void)
    
    var body: some View {
        Button(action: {
            // Open Wikipedia page about the herb
            print("Herb label \(herbName) tapped.")
            showSafari.toggle()
//            onLabelTapped()
        }) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(herbImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        
                        Text(herbName)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(binomialName)
                            .font(.system(size: 13))
                            .foregroundColor(Color.black.opacity(0.6))
                    }
                    .padding(.top)
                    
                    Spacer()
                }
            }
            .background(Color.white)
            .overlay(
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 6)
                    .clipped()
                , alignment: .leading
            )
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
            .padding(.horizontal, 17)
        }
        .fullScreenCover(isPresented: $showSafari, content: {
            if Locale.preferredLanguages[0].prefix(2) == "de" {
                SFSafariViewWrapper(url: URL(string: "https://de.wikipedia.org/wiki/"+herbName.localizedLowercase) ?? URL(string: "https://www.wikipedia.org")!)
                    .ignoresSafeArea()
            } else {
                SFSafariViewWrapper(url: URL(string: "https://en.wikipedia.org/wiki/"+herbName) ?? URL(string: "https://www.wikipedia.org")!)
                    .ignoresSafeArea()
            }
        })
    }
}

struct FancyToastView_Previews: PreviewProvider {
    static var previews: some View {
        FancyToastView(herbName: "Basil", binomialName: "Ocimum basilicum", herbImageName: "Basil")
    }
}
