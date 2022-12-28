//
//  HerbSnapApp.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 09.12.22.
//

import SwiftUI

@main
struct HerbSnapApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                // Transparent color for the top safeArea
                GeometryReader { reader in
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .opacity(0.6)
                        .ignoresSafeArea(edges: .top)
                }
            }
        }
    }
}
