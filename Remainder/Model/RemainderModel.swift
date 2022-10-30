//
//  Model.swift
//  Remainder
//
//  Created by Kaan Yeyrek on 10/26/22.
//

import Foundation
import RealmSwift

class RemainderModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
}
