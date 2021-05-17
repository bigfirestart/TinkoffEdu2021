//
//  RequestSenderMock.swift
//  TinkoffEduUnitTests
//
//  Created by Кирилл Лукьянов on 05.05.2021.
//

import Foundation
@testable import Tinkoff_Edu

class RequestSenderMock<T>: IRequestSender where T: IParser {
    var callsCount = 0
    var config: [RequestConfig<T>?] = []
    
    func send<Parser>(config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model, Error>) -> Void) where Parser: IParser {
        self.callsCount += 1
        self.config.append((config as? RequestConfig<T>))
    }
}
