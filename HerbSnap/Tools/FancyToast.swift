//
//  FancyToast.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 30.12.22.
//  Credits to Farhan Adji ("Create a Fancy Toast Component Using SwiftUI")
//  Source: https://betterprogramming.pub/swiftui-create-a-fancy-toast-component-in-10-minutes-e6bae6021984
//

import Foundation
import SwiftUI


struct FancyToast: Equatable {
    var herbName: [String]
    var binomialName: [String]
    var herbImageName: [String]
    var doubleToast: Bool = false
    var duration: Double = .infinity
}

struct FancyToastModifier: ViewModifier {
    @Binding var toast: FancyToast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                
                if toast.doubleToast == true {
                    FancyToastView(
                        herbName: toast.herbName[0],
                        binomialName: toast.binomialName[0],
                        herbImageName: toast.herbImageName[0])
                    FancyToastView(
                        herbName: toast.herbName[1],
                        binomialName: toast.binomialName[1],
                        herbImageName: toast.herbImageName[1])
                } else {
                    FancyToastView(
                        herbName: toast.herbName[0],
                        binomialName: toast.binomialName[0],
                        herbImageName: toast.herbImageName[0])
                }
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
