//
//  ThemesPickerDelegate.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 10.03.2021.
//

import Foundation
import UIKit

protocol ThemesPickerDelegate: class {
    func didChangeTheme(_ : Theme)
}

enum Theme {
    case classic, day, night
}

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var navColor: UIColor { get }
    var textColor: UIColor { get }
    var leftBubbleColor: UIColor { get }
    var rigthBubbleColor: UIColor { get }
    var userIntefaceStyle: UIUserInterfaceStyle { get }
}

extension Theme {
    var appTheme: ThemeProtocol {
        switch self {
            case .classic: return ClassicTheme()
            case .day: return DayTheme()
            case .night: return NigthTheme()
        }
    }

}

class ClassicTheme: ThemeProtocol {
    let backgroundColor = UIColor.white

    let navColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)

    let textColor = UIColor.black

    let leftBubbleColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)

    let rigthBubbleColor = UIColor(red: 220/255, green: 247/255, blue: 197/255, alpha: 1)

    let userIntefaceStyle = UIUserInterfaceStyle.light

}

class DayTheme: ThemeProtocol {
    let backgroundColor = UIColor.white

    let navColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)

    let textColor = UIColor.black

    let leftBubbleColor = UIColor(red: 234/255, green: 235/255, blue: 237/255, alpha: 1)

    let rigthBubbleColor = UIColor(red: 67/255, green: 137/255, blue: 249/255, alpha: 1)

    let userIntefaceStyle = UIUserInterfaceStyle.light

}

class NigthTheme: ThemeProtocol {
    let backgroundColor = UIColor.black

    let navColor =  UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)

    let textColor = UIColor.white

    let leftBubbleColor = UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)

    let rigthBubbleColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)

    let userIntefaceStyle = UIUserInterfaceStyle.dark

}

class TheamedUIView: UIView {}
class TheamedUILabel: UILabel {}
class TheamedUIButton: UIButton {}
