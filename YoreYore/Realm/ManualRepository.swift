//
//  MenualRepository.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation
import RealmSwift

class ManualRepository {
    static let shared = ManualRepository()
    
    let realm = try! Realm()
    func createItem(_ data: ManualTable) {
//        print(self.realm.configuration.fileURL)
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("realm create fail", error)
        }
        
//        let data = realm.objects(ManualTable.self).first
    }
    func fetchItem() -> [ManualTable] {
        let result = realm.objects(ManualTable.self)
        return Array(result) // 정확한 타입을 써주자
    }
    func removeItem(_ item: ManualTable) {
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
