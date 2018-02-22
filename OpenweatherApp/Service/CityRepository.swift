//
//  CityRepository.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import os.log
import CoreData

class CityRepository {
    
    static let DEFAULT_CITY_NAMES = ["Moscow", "Kazan", "Samara"]
    
    static var shared = CityRepository()
    
    private init() {
        if  getAllCities().isEmpty {
            prepareCities()
        } else {
            os_log("Cities already initialized")
        }
    }
    
    func getAllCities() -> [City] {
        var foundCities: [City] = []
        
        let context =  PersistenceService.viewContext
        
        context.performAndWait {
            let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
            let cityEntites = try! PersistenceService.viewContext.fetch(fetchRequest)
            foundCities = cityEntites.map() {(cityEntity) in City(name: cityEntity.name!)}
        }
        
        return foundCities
    }
    
    func addCity(_ city: City) -> Bool {
        var cityWasAdded = false
        
        let context =  PersistenceService.viewContext
        
        context.performAndWait {
            if findCity(by: city.name, context: context) == nil {
                do{
                    let cityEntity = CityEntity(context: context)
                    cityEntity.name = city.name
                    try context.save()
                    
                    cityWasAdded = true
                    os_log("Added city: %@", city.name)
                } catch {
                    os_log("Error while preparing cities: %@", error.localizedDescription)
                    context.rollback()
                }
            }
        }
        
        return cityWasAdded
    }
    
    // MARK: private methods
    
    private func findCity(by cityName:  String, context: NSManagedObjectContext) -> City? {
        var foundCities: [City] = []
        
        let context =  PersistenceService.viewContext
        
        context.performAndWait {
            let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@", cityName)
            let cityEntites = try! PersistenceService.viewContext.fetch(fetchRequest)
            foundCities = cityEntites.map() {(cityEntity) in City(name: cityEntity.name!)}
        }
        
        return foundCities.isEmpty ? nil : foundCities[0]
    }
    
    private func prepareCities() {
        let cities = CityRepository.DEFAULT_CITY_NAMES
        
        let context =  PersistenceService.viewContext
        
        context.performAndWait {
            do {
                for cityName in cities {
                    let cityEntity = CityEntity(context: context)
                    cityEntity.name = cityName
                }
                
                try context.save()
                
                os_log("Cities initialized with: %@", cities)
            } catch {
                os_log("Error while preparing cities: %@", error.localizedDescription)
                context.rollback()
            }
        }
    }
    
}
