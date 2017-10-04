//
//  Question.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/28/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import ObjectMapper

protocol AnyQuestion {

    var id: Int64 { get }
    var title: String { get }
    var body: String { get }

}

protocol QuestionEntity: AnyQuestion {

    var tags: [String] { get }
    var owner: Owner { get }
    var isAnswered: Bool { get }
    var viewCount: Int64 { get }
    var answerCount: Int64 { get }
    var score: Int64 { get }
    var lastActivityDate: Int64 { get }
    var creationDate: Int64 { get }
    var lastEditDate: Int64? { get }

}

struct Question {

    let id: Int64
    let title: String
    let body: String
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount: Int64
    let answerCount: Int64
    let score: Int64
    let lastActivityDate: Int64
    let creationDate: Int64
    let lastEditDate: Int64?

}

extension Question: QuestionEntity {

    init(any: QuestionEntity) {
        self.init(id: any.id,
                  title: any.title,
                  body: any.body,
                  tags: any.tags,
                  owner: any.owner,
                  isAnswered: any.isAnswered,
                  viewCount: any.viewCount,
                  answerCount: any.answerCount,
                  score: any.score,
                  lastActivityDate: any.lastActivityDate,
                  creationDate: any.creationDate,
                  lastEditDate: any.lastEditDate)
    }

}

extension Question: ImmutableMappable {

    init(map: Map) throws {
        self.init(
            id: try map.value("question_id"),
            title: try map.value("title"),
            body: try map.value("body"),
            tags: try map.value("tags"),
            owner: try map.value("owner"),
            isAnswered: try map.value("is_answered"),
            viewCount: try map.value("view_count"),
            answerCount: try map.value("answer_count"),
            score: try map.value("score"),
            lastActivityDate: try map.value("last_activity_date"),
            creationDate: try map.value("creation_date"),
            lastEditDate: try? map.value("last_edit_date")
        )
    }

}
