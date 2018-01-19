//
//  Errors.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 18/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import Foundation


enum Errors: Error {
    case message(String)
    case fatal(num: Int, message: String)
    
    func handler() {
        switch self {
        case .message(let str):
            print(str)
        case .fatal(num: let I, message: let S):
            print("response number:\(I), message \(S)")
        }
    }
}

