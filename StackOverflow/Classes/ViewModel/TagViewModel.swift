//
//  TagViewModel.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/27/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import RxSwift
import RxCocoa
import ObjectMapper

struct TagViewModel {

    var data = Variable<[Tag]>([])
    private let api: TagSynchronizing
    private let disposeBag = DisposeBag()

    init(api: TagSynchronizing) {
        self.api = api
    }

    func find(through url: URL) {
        let result = api.sync(through: url).map { value -> [Tag] in
            guard let items = value["items"] else {
                fatalError("An error occurred with sync")
            }
            return try Mapper<Tag>().mapArray(JSONObject: items)
        }.subscribe { (event) in
            if case .next(let element) = event {
                self.data.value = element
            }
        }
        result.disposed(by: disposeBag)
    }

}
