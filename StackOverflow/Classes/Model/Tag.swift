//
//  Tag.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/27/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import ObjectMapper

protocol AnyTag {

    var name: String { get }

}

protocol TagEntity: AnyTag {

    var hasSynonyms: Bool { get }
    var isModeratorOnly: Bool { get }
    var isRequired: Bool { get }
    var count: Int64 { get }

}

struct Tag {

    let name: String
    let hasSynonyms: Bool
    let isModeratorOnly: Bool
    let isRequired: Bool
    let count: Int64

}

extension Tag: TagEntity {

    init(any: TagEntity) {
        self.init(name: any.name,
                  hasSynonyms: any.hasSynonyms,
                  isModeratorOnly: any.isModeratorOnly,
                  isRequired: any.isRequired,
                  count: any.count)
    }

}

extension Tag: ImmutableMappable {

    init(map: Map) throws {
        self.init(
                name: try map.value("name"),
                hasSynonyms: try map.value("has_synonyms"),
                isModeratorOnly: try map.value("is_moderator_only"),
                isRequired: try map.value("is_required"),
                count: try map.value("count")
        )
    }

}
