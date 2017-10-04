//
//  Alamofire+Rx.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/27/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import Alamofire
import RxSwift

struct Service {

    func request(through endPoint: URL) -> Observable<[String:AnyObject]> {
        return Observable.create { observer in
            Alamofire.request(endPoint, method: .get)
                .validate(statusCode: 200..<500)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let JSON):
                        guard let json = JSON as? [String:AnyObject] else {
                            fatalError("An error occurred with JSON")
                        }
                        observer.on(.next(json))
                    case .failure(let error):
                        observer.on(.error(error))
                    }
                    observer.on(.completed)
            }
            return Disposables.create()
        }
    }

}
