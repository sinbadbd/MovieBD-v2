//
//  MyDbManager.swift
//  MovieDB-v2
//
//  Created by Imran on 5/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@available(iOS 13.0, *)
class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func saveFavorite(dic:[String:Any])  {
        let  favorite = NSEntityDescription.insertNewObject(forEntityName:"MovieDataSave", into: context!) as! MovieDataSaveTable
//        favorite.is
        favorite.isFavorite = (dic["isFavorite"] != nil)
        
        
       do{
           try context?.save()
           
       }catch{
           print("not data found")
       }
    }
    
    
//       func getStudentData()  {
//        var student : MovieDataSaveTable? //[MovieDataSaveTable]()
//       
//           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
//           
//           do{
//               student = try context?.fetch(fetchRequest) //as! [MovieDataSaveTable]
//           }catch {
//               print("can't get data")
//           }            return student
//       }
    
}
