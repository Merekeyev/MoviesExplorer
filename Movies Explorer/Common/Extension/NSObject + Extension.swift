//
//  NSObject + Extension.swift
//  Movies Explorer
//
//  Created by Temirlan on 11.06.2023.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
