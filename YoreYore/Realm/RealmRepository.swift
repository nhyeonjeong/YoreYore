//
//  RealmRepository.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import Foundation
import RealmSwift

class RealmRepository {
    static let shared = RealmRepository()
    
    let realm = try! Realm()
    func createItem(_ data: BookmarkTable) {
        print(self.realm.configuration.fileURL)
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("realm create fail", error)
        }
    }
    func fetchItem() -> [FoodTable] {
        let result = realm.objects(FoodTable.self)
        return Array(result) // 정확한 타입을 써주자
    }
    func removeItem(_ item: FoodTable) {
        do {
            try realm.write {
                realm.delete(item)
                print("realm delete")
            }
        } catch {
            print(error)
        }
    }
}
