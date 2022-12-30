//
//  View+ToastView.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 30.12.22.
//

import Foundation
import SwiftUI

extension View {
    func toastView(toast: Binding<FancyToast?>) -> some View {
        self.modifier(FancyToastModifier(toast: toast))
    }
}
