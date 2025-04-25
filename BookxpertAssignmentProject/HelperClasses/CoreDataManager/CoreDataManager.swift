//
//  CoreDataManager.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 26/04/25.
//

import Foundation
import CoreData
import UIKit

enum Entity: String {
    case userEntity = "UserEntity"
    case homeEntity = "HomeEntity"
}

struct HomeEntityDataModel {
    let id: String?
    let name: String?
    let email: String?
}

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private var manageObjectContext: NSManagedObjectContext!
    
    func saveData(entity: Entity, dataModel: HomeEntityDataModel) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: entity.rawValue, in: manageContent)!
        
        let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
        
        if entity == .userEntity {
            users.setValue(dataModel.email, forKeyPath: "email")
        } else {
            users.setValue(dataModel.id, forKeyPath: "id")
            users.setValue(dataModel.name, forKeyPath: "name")
        }
        
        
        do{
            try manageContent.save()
        } catch let error as NSError {
            
            print("could not save . \(error), \(error.userInfo)")
        }
        
        fetchData(entity: entity)
    }
    
    func fetchData(entity: Entity) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        if entity == .userEntity {
            do {
                let result = try manageContent.fetch(fetchData)
                for data in result as! [NSManagedObject]{
                    print("User Entity Fetch =>", data.value(forKeyPath: "email") as Any)
                }
            }catch {
                print("err")
            }
        } else {
            do {
                let result = try manageContent.fetch(fetchData)
                for data in result as! [NSManagedObject]{
                    print(data.value(forKeyPath: "id") as Any)
                    print(data.value(forKeyPath: "name") as Any)
                }
            }catch {
                print("err")
            }
        }
        
        
    }
}
