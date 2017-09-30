//
//  TagSynchronizing.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/27/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import RxSwift

protocol Synchronizing: class {

    func sync(through endPoint: URL) -> Observable<[String:AnyObject]>

}
