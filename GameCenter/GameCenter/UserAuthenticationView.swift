//
//  UserAuthenticationView.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 28/08/23.
//

import SwiftUI

/// Usado para mostrar as view controllers dentro do swift ui
struct UserAuthenticationView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    var vcInstance: UIViewController
    
    init(vc: some UIViewController) {
        vcInstance = vc
    }
    
    mutating func updateVC(_ vc: some UIViewController) {
        self.vcInstance = vc
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return vcInstance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        return
    }
}
