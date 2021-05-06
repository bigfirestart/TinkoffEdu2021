//
//  Pop.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 29.04.2021.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        guard let fromVc = fromViewController,
            let toVc = toViewController,
            let snapshotView = fromVc.view.snapshotView(afterScreenUpdates: false)
            else { return }
        let finalFrame = transitionContext.finalFrame(for: fromVc)
        toVc.view.frame = finalFrame
        containerView.addSubview(toVc.view)
        containerView.sendSubviewToBack(toVc.view)
        snapshotView.frame = fromVc.view.frame
        containerView.addSubview(snapshotView)
        fromVc.view.removeFromSuperview()
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // Below line will start from right
            snapshotView.frame = finalFrame.offsetBy(dx: -finalFrame.size.width, dy: 0)
        }, completion: {(finished) in
            snapshotView.removeFromSuperview()
            transitionContext.completeTransition(finished)
        })
    }
}
