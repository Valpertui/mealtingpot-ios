//
//  RealmObject.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 24/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    func save(){
        let realm = try! Realm()
        realm.write { () -> Void in
            realm.add(self, update:true)
        }
    }
}