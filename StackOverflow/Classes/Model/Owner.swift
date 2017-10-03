//
//  Owner.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/30/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import ObjectMapper

protocol AnyOwner {

    var id: Int64 { get }
    var name: String { get }

}

protocol OwnerEntity: AnyOwner {

    var reputation: Int64 { get }
    var type: String { get }
    var acceptRate: Int64? { get }
    var avatar: String { get }
    var link: String { get }

}

struct Owner {

    let id: Int64
    let name: String
    let reputation: Int64
    let type: String
    let acceptRate: Int64?
    let avatar: String
    let link: String

}

extension Owner: OwnerEntity {

    init(any: OwnerEntity) {
        self.init(id: any.id,
                  name: any.name,
                  reputation: any.reputation,
                  type: any.type,
                  acceptRate: any.acceptRate,
                  avatar: any.avatar,
                  link: any.link)
    }

}

extension Owner: ImmutableMappable {

    init(map: Map) throws {
        self.init(
            id: try map.value("user_id"),
            name: try map.value("display_name"),
            reputation: try map.value("reputation"),
            type: try map.value("user_type"),
            acceptRate: try? map.value("accept_rate"),
            avatar: try map.value("profile_image"),
            link: try map.value("link")
        )
    }

}
