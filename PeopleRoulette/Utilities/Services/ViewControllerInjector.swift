//
//  ViewControllerInjector.swift
//  DigitalAMS
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import SwinjectStoryboard

protocol ViewControllerInjecting {
    func inject(viewController identifier: String, in storyboard: String) -> UIViewController
}

struct ViewControllerInjector: ViewControllerInjecting {
    func inject(viewController identifier: String, in storyboard: String) -> UIViewController {
        let viewController = SwinjectStoryboard.create(
            name: storyboard,
            bundle: nil,
            container: SwinjectStoryboard.defaultContainer
            ).instantiateViewController(withIdentifier: identifier)
        
        return viewController
    }
}
