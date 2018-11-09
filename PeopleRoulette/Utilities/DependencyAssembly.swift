//
//  DependencyAssembly.swift
//  DigitalAMS
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    
    class func registerStoryboards() {
        Container.loggingFunction = nil
        
        defaultContainer.storyboardInitCompleted(PeopleRouletteViewController.self) { resolver, controller in
            controller.peopleRouletteViewModel = resolver.resolve(PeopleRouletteViewModel.self)
            controller.viewControllerInjector = resolver.resolve(ViewControllerInjecting.self)
        }
        
        defaultContainer.storyboardInitCompleted(UserDetailsViewController.self) { resolver, controller in
            controller.userDetailsViewModel = resolver.resolve(UserDetailsViewModel.self)
        }
    }
    
    class func registerViewModels() {
        defaultContainer.register(PeopleRouletteViewModel.self) { resolver in
            let viewModel = PeopleRouletteViewModel()
            viewModel.usersDownloader = resolver.resolve(UsersDownloading.self)
            viewModel.usersRetriever = resolver.resolve(UsersRetrieving.self)
            return viewModel
        }
        
        defaultContainer.register(UserDetailsViewModel.self) { resolver in
            let viewModel = UserDetailsViewModel()
            return viewModel
        }
    }
    
    class func registerServices() {        
        defaultContainer.register(ViewControllerInjecting.self) { _ in
            return ViewControllerInjector()
        }
    }
    
    class func registerHandlers() {
        defaultContainer.register(RealmHandler.self) { _ in
            return RealmHandler()
        }
        
        defaultContainer.register(ObjectSaving.self) { _ in
            return RealmHandler()
        }
        
        defaultContainer.register(ObjectRetrieving.self) { _ in
            return RealmHandler()
        }
        
        defaultContainer.register(ObjectPurging.self) { _ in
            return RealmHandler()
        }
        
        defaultContainer.register(APIRequesting.self) { _ in
            return APIRequestHandler()
        }
        
        defaultContainer.register(UsersDownloading.self) { resolver in
            let handler = UsersHandler()
            handler.apiHandler = resolver.resolve(APIRequesting.self)
            handler.realmSaver = resolver.resolve(ObjectSaving.self)
            handler.realmPurger = resolver.resolve(ObjectPurging.self)
            return handler
        }
        
        defaultContainer.register(UsersRetrieving.self) { resolver in
            let handler = UsersHandler()
            handler.realmRetriever = resolver.resolve(ObjectRetrieving.self)
            return handler
        }
    }
    
    @objc class func setup() {
        registerStoryboards()
        registerHandlers()
        registerServices()
        registerViewModels()
    }
}
