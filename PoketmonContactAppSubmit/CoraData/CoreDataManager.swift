//
//  CoreDataManager.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/17/24.
//

import CoreData
import UIKit

class CoreDataManager {
    // Singleton 인스턴스로 앱 전체에서 CoreDataManager 공유 가능
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer  // NSPersistentContainer: 데이터 모델과 연관된 저장소를 관리하는 객체
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ContactModel")   // ContactModel을 사용하여 초기화
        persistentContainer.loadPersistentStores { (description, error) in  // loadPersistentStores: 영구 저장소 load, 오류 발생시 앱 종료
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    // NSManagedObjectContext(관리 객체 컨텍스트) -> 객체 생성, 삭제, 편집 등을 수행하여 변경사항 관리 / 메인 스레드에서 실행됨
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 변동사항 저장
    func saveContext() {
        let context = persistentContainer.viewContext
        // context.hasChanges가 true이면 context.save를 통해 변경사항 저장
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

