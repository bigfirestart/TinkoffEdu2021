import UIKit

class Emitter {
    let particleEmitter = CAEmitterLayer()
    var superView: UIView
    
    init(view: UIView) {
        self.superView = view
    }
    
    func startAnimation(touches: Set<UITouch>) {
        particleEmitter.emitterPosition = touches.first?.location(in: self.superView) ?? CGPoint()
        particleEmitter.emitterShape = CAEmitterLayerEmitterShape.circle
        particleEmitter.emitterSize = CGSize(width: 5, height: 5)
        particleEmitter.backgroundColor = UIColor.red.cgColor
        particleEmitter.lifetime = 1
        
        let cell = CAEmitterCell()
        
        cell.birthRate = 30
        cell.contents = UIImage(named: "particle")?.cgImage
        cell.contentsScale = 5
        cell.lifetime = 1
        cell.lifetimeRange = 1
        cell.velocity = 150
        cell.velocityRange = 100
        cell.emissionRange = .pi * 2
        cell.spin = 3
        cell.spinRange = 2
        cell.scaleRange = 3
        cell.scaleSpeed = -0.10
        cell.yAcceleration = 30.0
        cell.xAcceleration = -5
        
        particleEmitter.emitterCells = [cell]
        
        self.superView.layer.addSublayer(particleEmitter)
    }
    
    func moveAnimation(touches: Set<UITouch>) {
        particleEmitter.emitterPosition = touches.first?.location(in: self.superView) ?? CGPoint()
    }
    
    func stopAnimation() {
        particleEmitter.removeFromSuperlayer()
    }
}
