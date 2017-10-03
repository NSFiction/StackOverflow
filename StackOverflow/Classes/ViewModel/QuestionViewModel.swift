//
//  QuestionViewModel.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/30/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import RxSwift
import RxCocoa
import ObjectMapper

final class QuestionViewModel {

    var data = Variable<[Question]>([])
    private let api: Synchronizing
    private let disposeBag = DisposeBag()

    init(api: Synchronizing) {
        self.api = api
    }

    func find(through url: URL) {
        let result = api.sync(through: url).map { value -> [Question] in
            guard let items = value["items"] else {
                fatalError("An error occurred with sync")
            }
            return try Mapper<Question>().mapArray(JSONObject: items)
        }.subscribe { event in
            if case .next(let element) = event {
                self.data.value = element
            }
        }
        result.addDisposableTo(disposeBag)
    }
}
