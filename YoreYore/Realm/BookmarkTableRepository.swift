//
//  RealmRepository.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import Foundation
import RealmSwift

class BookmarkTableRepository {
    static let shared = BookmarkTableRepository()
    
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
        
        let data = realm.objects(BookmarkTable.self).first
    }
    
    func createFoodItem(_ item: FoodTable, foodTypeIdx: Int) {
        let data = realm.objects(BookmarkTable.self)
        do {
            try realm.write {
                data[foodTypeIdx].foodList.append(item)
            }
        } catch {
            print(#function, "error")
        }
    }
    
    func fetchItem() -> [BookmarkTable] {
        let result = realm.objects(BookmarkTable.self)
        return Array(result) // 정확한 타입을 써주자
    }
    func removeItem(_ item: BookmarkTable) {
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
