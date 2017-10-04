//
//  StackOverflowAPI.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/27/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import Foundation

struct StackOverflowAPI {

    static let baseUrl = "https://api.stackexchange.com/2.2"

    enum Endpoints {
        case answer(String)
        case question(String)
        case tag

        func url() -> String {
            switch self {
            case .answer(let element):
                return "\(StackOverflowAPI.baseUrl)/questions/\(element)/answers?order=desc&sort=activity&site=stackoverflow"
            case .question(let element):
                return "\(StackOverflowAPI.baseUrl)/questions?pagesize=20&order=desc&sort=activity&tagged=\(element)&site=stackoverflow&filter=!9YdnSIN18"
            case .tag:
                return "\(StackOverflowAPI.baseUrl)/tags?order=desc&sort=popular&site=stackoverflow"
            }
        }
    }

    static func answer(through element: String) -> URL? {
        return URL(string: Endpoints.answer(element).url())
    }

    static func question(through element: String) -> URL? {
        return URL(string: Endpoints.question(element).url())
    }

    static func tag() -> URL? {
        return URL(string: Endpoints.tag.url())
    }

}
