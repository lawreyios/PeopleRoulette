//
//  APIRequestHandler.swift
//  DigitalAMS
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol APIRequesting {
    func sendRequest(_ request: APIRequest, completion: @escaping (_ result: Bool, _ data: Any?, _ errorMessage: String) -> Void)
}

class APIRequestHandler: APIRequesting {
    
    private var manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            Domain.typicode: .disableEvaluation
        ]
        
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    func sendRequest(_ request: APIRequest, completion: @escaping (Bool, Any?, String) -> Void) {
        manager.request(request.url,
                          method: request.method,
                          parameters: request.parameters,
                          headers: request.headers).validate().responseJSON { [weak self] response in
                            guard let weakSelf = self else {
                                print("Self has been deallocated.")
                                return
                            }
                            
                            weakSelf.processResponse(response) { success, data, message in
                                completion(success, data, message)
                            }
        }
    }
    
    private func processResponse(_ response: DataResponse<Any>, completion: @escaping (Bool, Any?, String) -> Void) {
        guard let httpResponse = response.response else {
            completion(false, nil, AlertMessage.networkError)
            return
        }
        switch httpResponse.statusCode {
        case .success:
            guard let responseData = response.result.value else {
                completion(false, nil, AlertMessage.requestFailure)
                return
            }
            completion(true, responseData, .empty)
        default:
            completion(false, nil, AlertMessage.requestFailure)
        }
    }
}
