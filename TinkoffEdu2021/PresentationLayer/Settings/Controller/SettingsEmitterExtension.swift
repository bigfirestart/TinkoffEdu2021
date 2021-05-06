//
//  SettingsEmitterExtension.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 29.04.2021.
//

import UIKit

extension SettingsViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        emitter?.startAnimation(touches: touches)
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        emitter?.stopAnimation()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        emitter?.stopAnimation()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        emitter?.moveAnimation(touches: touches)
    }
}
