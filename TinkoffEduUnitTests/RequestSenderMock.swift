//
//  RequestSenderMock.swift
//  TinkoffEduUnitTests
//
//  Created by Кирилл Лукьянов on 05.05.2021.
//

import Foundation
@testable import Tinkoff_Edu

class RequestSenderMock: IRequestSender {
    var callsCount = 0
    var config: Any?
    
    func send<Parser>(config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model, Error>) -> Void) where Parser: IParser {
        self.callsCount += 1
        self.config = config
    }
}
