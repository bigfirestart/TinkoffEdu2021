//
//  Push.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 29.04.2021.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerVw = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        guard let fromVc = fromViewController, let toVc = toViewController else { return }
        let finalFrame = transitionContext.finalFrame(for: toVc)
        toVc.view.frame = finalFrame.offsetBy(dx: -finalFrame.size.width / 2, dy: 0)
        containerVw.addSubview(toVc.view)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVc.view.frame = finalFrame
            fromVc.view.alpha = 0.5
        }, completion: {(finished) in
            transitionContext.completeTransition(finished)
            fromVc.view.alpha = 1.0
        })
    }
}
