//
//  ViewControllerInjectorSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Nimble
import Quick
import Swinject
import SwinjectStoryboard

@testable import PeopleRoulette

class ViewControllerInjectorSpec: QuickSpec {
    override func spec() {
        let viewControllerInjector = SwinjectStoryboard.defaultContainer.resolve(ViewControllerInjecting.self)!
        
        describe("when PeopleRouletteViewController is injected") {
            it("should load an instance of it") {
                expect(viewControllerInjector.inject(viewController: ViewIdentifier.peopleRouletteViewController, in: Storyboard.main)).to(beAKindOf(PeopleRouletteViewController.self))
            }
        }
        
        describe("when UsersListViewController is injected") {
            it("should load an instance of it") {
                expect(viewControllerInjector.inject(viewController: ViewIdentifier.usersListViewController, in: Storyboard.main)).to(beAKindOf(UsersListViewController.self))
            }
        }
        
        describe("when UserDetailsViewController is injected") {
            it("should load an instance of it") {
                expect(viewControllerInjector.inject(viewController: ViewIdentifier.userDetailsViewController, in: Storyboard.main)).to(beAKindOf(UserDetailsViewController.self))
            }
        }
    }
}
