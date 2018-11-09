//
//  APIRequest.swift
//  DigitalAMS
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Alamofire

enum HTTPBodyEncoding {
    case json
    case queryString
    case httpBody
    case undefined
}

struct APIRequest {
    let url: String
    let method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    let encoding: Any
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: Any = HTTPBodyEncoding.json) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.encoding = encoding
    }
}
