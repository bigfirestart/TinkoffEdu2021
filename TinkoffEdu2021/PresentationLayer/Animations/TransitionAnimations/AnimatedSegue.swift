//
//  AnimatedSegue.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 29.04.2021.
//

import Foundation
import UIKit

class AnimatedSegue: UIStoryboardSegue {
    override func perform() {
        destination.transitioningDelegate = self
        destination.modalPresentationStyle = .overCurrentContext
        source.present(destination, animated: true, completion: nil)
        super.perform()
    }
}

extension AnimatedSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushAnimation()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopAnimation()
    }
}
