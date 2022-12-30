//
//  SFSafariViewWrapper.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 30.12.22.
//

import Foundation
import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        let sfViewController = SFSafariViewController(url: url)
        sfViewController.preferredControlTintColor = UIColor(.accentColor)
        return sfViewController
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
