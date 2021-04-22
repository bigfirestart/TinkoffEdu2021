//
//  Network.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 21.04.2021.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

protocol IRequestSender {
    func send<Parser>(config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, Error>) -> Void)
}

class RequestSender: IRequestSender {
    let session = URLSession.shared
    func send<Parser>(config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, Error>) -> Void) {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(NetworkError.badURL))
            return
        }
        let task = session.dataTask(with: urlRequest) {(data: Data?, _: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(error))
                return
                
            }
            guard
                let data = data,
                let parsedModel: Parser.Model = config.parser.parse(data: data)
            else {
                completionHandler(.failure(ParsingError.error))
                return
                
            }
            completionHandler(.success(parsedModel))
        }
        task.resume()
       
    }
}

enum NetworkError: Error {
    case badURL
}

enum ParsingError: Error {
    case error
}
