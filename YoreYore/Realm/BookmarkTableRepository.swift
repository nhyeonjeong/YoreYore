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
//        print(self.realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("realm create fail", error)
        }
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
        return Array(result)
    }
    // foodList만 가져오기
    func fetchItem(_ foodTypeIdx: Int) -> [FoodTable] {
        let result = realm.objects(BookmarkTable.self)
        return Array(result[foodTypeIdx].foodList)
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
