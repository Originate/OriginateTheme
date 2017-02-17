//
//  String+StringInitializable.swift
//  OriginateTheme
//
//  Created by Robert Weindl on 2017-02-14.
//  Copyright © 2017 Originate Inc. All rights reserved.
//

import Foundation

extension String: StringInitializable {
    init(string s: String) {
        self = s
    }
}
