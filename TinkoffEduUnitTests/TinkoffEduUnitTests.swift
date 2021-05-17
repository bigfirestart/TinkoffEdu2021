//
//  TinkoffEduUnitTests.swift
//  TinkoffEduUnitTests
//
//  Created by Кирилл Лукьянов on 05.05.2021.
//

import XCTest

@testable import Tinkoff_Edu

class TinkoffEduUnitTests: XCTestCase {
    func testCoreApi_ImageList() {
        // Arrange
        let requestSenderMock = RequestSenderMock<ImageListParser>()
        let apiService = PixabayAPIService(requestSender: requestSenderMock)
        
        // Act
        apiService.getImageList(completionHandler: {_, _ in })
       
        let config = requestSenderMock.config
        
        // Assert
        XCTAssertEqual(requestSenderMock.callsCount, 1)
        XCTAssertFalse(config.contains(where: {$0 == nil}))
        XCTAssertEqual(config.count, 1)
    }
    
    func testCoreApi_ImageDownload() {
        // Arrange
        let requestSenderMock = RequestSenderMock<DownloadImageParser>()
        let apiService = PixabayAPIService(requestSender: requestSenderMock)
        let imgUrl = "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492_150.jpg"
        
        // Act
        apiService.downloadImage(urlString: imgUrl, completionHandler: {_, _ in })
       
        let config = requestSenderMock.config
        let domain = config[0]?.request.urlRequest?.url?.absoluteString
        
        // Assert
        XCTAssertEqual(requestSenderMock.callsCount, 1)
        XCTAssertFalse(config.contains(where: {$0 == nil}))
        XCTAssertEqual(config.count, 1)
        XCTAssertEqual(domain, imgUrl)
    }
}
