//
//  Mock.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 04.03.2021.
//

import Foundation

class Mock {
    // swiftlint:disable:next line_length
    static var sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    static var onlineConversationsList = [
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: sampleText,
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date()),
            online: true,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: "Fredi keks",
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: nil,
            date: Calendar.current.date(byAdding: .day, value: +12, to: Date()),
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: sampleText,
            date: Calendar.current.date(byAdding: .hour, value: -23, to: Date()),
            online: true,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: nil,
            date: Calendar.current.date(byAdding: .weekOfMonth, value: +30, to: Date()),
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: nil,
            message: nil,
            date: nil,
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: sampleText,
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date()),
            online: false,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: "Fredi keks",
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            online: false,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: nil,
            date: Calendar.current.date(byAdding: .day, value: +12, to: Date()),
            online: false,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: sampleText,
            date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()),
            online: false,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: nil,
            date: Calendar.current.date(byAdding: .weekOfMonth, value: -30, to: Date()),
            online: false,
            hasUnreadMessages: false
        )
    ]

    static var historyConversationsList = [
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: sampleText,
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date()),
            online: false,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: "Fredi keks",
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            online: false,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: nil,
            date: Calendar.current.date(byAdding: .day, value: +12, to: Date()),
            online: false,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: sampleText,
            date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()),
            online: false,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: nil,
            date: Calendar.current.date(byAdding: .weekOfMonth, value: -30, to: Date()),
            online: false,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: sampleText,
            date: Calendar.current.date(byAdding: .day, value: 0, to: Date()),
            online: true,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: "Fredi keks",
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: "Fredi keks",
            message: nil,
            date: Calendar.current.date(byAdding: .day, value: +12, to: Date()),
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: sampleText,
            date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()),
            online: true,
            hasUnreadMessages: true
        ),
        ConversationsCellConfiguration(
            name: sampleText,
            message: nil,
            date: Calendar.current.date(byAdding: .weekOfMonth, value: +30, to: Date()),
            online: true,
            hasUnreadMessages: false
        ),
        ConversationsCellConfiguration(
            name: nil,
            message: nil,
            date: nil,
            online: true,
            hasUnreadMessages: false
        )
    ]

    static var messages = [
        ConversationCellConfiguration(
            text: nil,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: nil,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: nil,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: nil,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: nil,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: true
        ),
        ConversationCellConfiguration(
            text: sampleText,
            isIncoming: false
        ),
        ConversationCellConfiguration(
            text: "ok",
            isIncoming: false
        )
    ]
}
