//
//  TagViewModel.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/27/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import RxSwift
import ObjectMapper

struct TagViewModel {

    private let api: TagSynchronizing
    private let disposeBag = DisposeBag()

    init(api: TagSynchronizing) {
        self.api = api
    }

    func find(url: URL) -> Observable<[Tag]> {
        return api.sync(through: url).map { value -> [Tag] in
            guard let items = value["items"] else {
                fatalError("An error occurred with sync")
            }
            return try Mapper<Tag>().mapArray(JSONObject: items)
        }
    }

}
