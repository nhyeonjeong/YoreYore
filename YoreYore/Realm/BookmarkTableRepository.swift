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
    
    var realm = try! Realm()
    // BookmarkTable Create
    func createItem(_ data: BookmarkTable) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("realm create fail", error)
        }
    }
    // 북마크한 레시피 Create
    func createFoodItem(_ item: FoodTable, bookmark: BookmarkTable) {
        do {
            try realm.write {
                bookmark.foodList.append(item)
            }
        } catch {
            print(error)
        }
    }
    // BookmarkTable Read
    func fetchItem() -> [BookmarkTable] {
        let result = realm.objects(BookmarkTable.self)
        return Array(result)
    }
    // BookmarkTable에서 foodList만 Read
    func fetchItem(_ foodType: ClassifyList) -> [FoodTable] {
        let result = realm.objects(BookmarkTable.self)
        let bookmark: [BookmarkTable] = Array(result).filter { bookmarkTableData in
            bookmarkTableData.foodTypeRawValue == foodType.rawValue
        }
        return bookmark.isEmpty ? [] : Array(bookmark[0].foodList)
    }
    
    // BookmarkTable Delete
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
