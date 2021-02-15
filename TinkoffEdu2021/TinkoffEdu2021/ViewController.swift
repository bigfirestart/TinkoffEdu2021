//
//  ViewController.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var logger: Logger = Logger()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.info(message: "viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.info(message: "viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.info(message: "viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logger.info(message: "viewDidLayoutSubviews")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.info(message: "viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.info(message: "viewDidDisappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.info(message: "viewDidLoad")
    }

}

