//
//  RealmService.swift
//  Swift5Realm
//
//  Created by Nir Leshem on 09/01/2021.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()

    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("\(#function)", error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String : Any]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("\(#function)", error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("\(#function)", error)
        }
    }
}

extension RealmService {
    func getAllRealmUsers() -> Results<RealmUser> {
        return realm.objects(RealmUser.self)
    }
    
//    /* Query using Contains */
//    realm.objects(RealmUser.self).filter("name contains %@", "V")
//
//    /* Query using a predicate string */
//    var tanDogs = realm.objects(Dog.self).filter("color = 'tan' AND name BEGINSWITH 'B'")
//
//    /* Query using an NSPredicate */
//    let predicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "tan", "B")
//    tanDogs = realm.objects(Dog.self).filter(predicate)
}
