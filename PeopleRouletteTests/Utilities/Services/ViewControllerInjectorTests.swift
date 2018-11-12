//
//  ViewControllerInjectorTests.swift
//  eShopFloor-iOS-SwiftTests
//
//  Created by Tan, JunHao Lawrence on 18/12/17.
//  Copyright © 2017 MSD GIN@S. All rights reserved.
//

import Nimble
import Quick
import Swinject
import SwinjectStoryboard

@testable import eShopFloor_iOS_Swift

class ViewControllerInjectorTests: QuickSpec {
    override func spec() {
        let viewControllerInjector = SwinjectStoryboard.defaultContainer.resolve(ViewControllerInjecting.self)!
        
        describe("when LocationListViewController is injected") {
            it("should load an instance of it") {
                expect(viewControllerInjector.inject(viewController: Constants.ViewIdentifiers.locationsListViewController, in: Constants.ViewIdentifiers.settings)).to(beAKindOf(LocationsListViewController.self))
            }
        }
    }
}
