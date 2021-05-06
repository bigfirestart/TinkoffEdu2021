//
//  AnimatedButton.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 29.04.2021.
//

import UIKit

class AnimatedTheamedUIButton: TheamedUIButton {
    func shake() {
        let animation1 = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation1.values = [0, -Double.pi / 20, Double.pi / 20, 0]
        animation1.keyTimes = [0, 0.1, 0.9, 1]
        animation1.duration = 0.3
        
        let animation2 = CAKeyframeAnimation(keyPath: "position.x")
        let x = layer.position.x
        animation2.values = [x, x - 5, x + 5, x]
        animation2.keyTimes = [0, 0.1, 0.5, 1]
        animation2.duration = 0.3
        
        let animation3 = CAKeyframeAnimation(keyPath: "position.y")
        let y = layer.position.y
        animation3.values = [y, y + 5, y - 5, y]
        animation3.keyTimes = [0.1, 0.25, 0.9, 1]
        animation3.duration = 0.3
        
        let animation = CAAnimationGroup()
        animation.animations = [animation1, animation2, animation3]
        animation.duration = 1.3
        animation.repeatCount = .infinity
        layer.add(animation, forKey: nil)
    }
    
    func stopShake() {
        layer.removeAllAnimations()
        let backAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        backAnimation.fromValue = layer.presentation()?.position
        backAnimation.toValue = layer.position
        backAnimation.duration = 0.2
        layer.add(backAnimation, forKey: #keyPath(CALayer.position))
    }
}
