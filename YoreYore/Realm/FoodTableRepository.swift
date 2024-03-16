//
//  FoodTableRepository.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation
import RealmSwift

class FoodTableRepository {
    static let shared = FoodTableRepository()
    
    let realm = try! Realm()
    func createItem(_ data: FoodTable) {
        print(self.realm.configuration.fileURL)
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("realm create fail", error)
        }
    }
    
    func createMenualItem(manualList: [ManualTable], foodItem: FoodTable) {
        do {
            for item in manualList {
                try realm.write {
                    foodItem.manualList.append(item)
                }
            }
        } catch {
            print(#function, "error")
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