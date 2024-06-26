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
    
    func createFoodItem(_ item: FoodTable, bookmark: BookmarkTable) {
        
        let data = realm.objects(BookmarkTable.self)
        do {
            try realm.write {
                bookmark.foodList.append(item)
            }
        } catch {
            print(error)
        }
    }
    func fetchItem() -> [BookmarkTable] {
        let result = realm.objects(BookmarkTable.self)
        return Array(result)
    }
    // foodList만 가져오기
    func fetchItem(_ foodType: ClassifyList) -> [FoodTable] {
        let result = realm.objects(BookmarkTable.self)
        let bookmark: [BookmarkTable] = Array(result).filter { bookmarkTableData in
            bookmarkTableData.foodTypeRawValue == foodType.rawValue
        }
        return bookmark.isEmpty ? [] : Array(bookmark[0].foodList)
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
