//
//  RequestModuleRequestModuleConfiguratorTests.swift
//  viperWorkspace
//
//  Created by iulik on 06/09/2018.
//  Copyright © 2018 iulik_Co. All rights reserved.
//

import XCTest
@testable import viperWorkspace

class RequestModuleModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = RequestModuleViewControllerMock()
        let configurator = RequestModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "RequestModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RequestModulePresenter, "output is not RequestModulePresenter")

        let presenter: RequestModulePresenter = viewController.output as! RequestModulePresenter
        XCTAssertNotNil(presenter.view, "view in RequestModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RequestModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RequestModuleRouter, "router is not RequestModuleRouter")

        let interactor: RequestModuleInteractor = presenter.interactor as! RequestModuleInteractor
        XCTAssertNotNil(interactor.output, "output in RequestModuleInteractor is nil after configuration")
    }

    class RequestModuleViewControllerMock: RequestModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
