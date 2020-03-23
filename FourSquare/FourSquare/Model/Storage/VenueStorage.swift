//
//  VenueStorage.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit
import CoreData

protocol VenueStorage {
    func getVenues(completion: @escaping ([Venue]?, Error?) -> Void)
    func store(venues: [Venue])
}

final class VenueStorageImpl: VenueStorage {
    
    // MARK: - Properties
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private lazy var managedContext: NSManagedObjectContext? = {
        guard let appDelegate = appDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Venue storage
    
    func getVenues(completion: @escaping ([Venue]?, Error?) -> Void) {
        guard let managedContext = managedContext else {
            print("smth went wrong with context: getVenues")
            return
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Venue")
        
        do {
            let venuesMO = try managedContext.fetch(fetchRequest)
            let venues: [Venue] = venuesMO.map {
                Venue(id: $0.value(forKey: "id") as! String,
                      name: $0.value(forKey: "name") as! String)
            }
            completion(venues, nil)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(nil, error)
        }
        
    }
    
    func store(venues: [Venue]) {
        guard let managedContext = managedContext else {
            print("smth went wrong with context: store venues")
            return
        }
        
        // Removing old objects first
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
            
            try managedContext.save()
            print("Succesfully removed old entities")
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
        
        // storing new objects
        venues.forEach {
            let entity = NSEntityDescription.entity(forEntityName: "Venue", in: managedContext)!
            let venue = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            
            venue.setValue($0.id, forKeyPath: "id")
            venue.setValue($0.name, forKey: "name")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            print("succesfully stored")
        }
    }
}
