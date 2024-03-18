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

    func removeItem(_ item: FoodTable) {
        do {
            try realm.write {
                realm.delete(item.manualList) // 하위계층부터 삭제후 레시피 삭제
                realm.delete(item)
                print("realm delete")
            }
        } catch {
            print(error)
        }
    }
}
