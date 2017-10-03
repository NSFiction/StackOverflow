//
//  ViewConfiguration.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 9/30/17.
//  Copyright © 2017 nFiction. All rights reserved.
//

import Foundation

protocol ViewConfiguration: class {
    func setupConstraints()
    func buildViewHierarchy()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
    }
}
