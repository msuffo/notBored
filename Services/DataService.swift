//
//  DataService.swift
//  NotBored
//
//  Created by Mathias Ruiz Hernandez on 4/11/21.
//

import Foundation

class DataService{
    
    static let shared = DataService()
    
    private var userSelectedMinPrice: Float = 0.0
    private var userSelectedMaxPrice: Float = 0.0
    private var numberOfParticipants: Int = 0
    private var aceptedTC: Bool = false
    private var selectedPrice: Bool = false
    
    func setUserSelectedMinPrice(_ value: Float){
        userSelectedMinPrice = value
    }
    
    func getUserSelectedMinPrice()-> Float{
         return userSelectedMinPrice
    }
    
    func setUserSelectedMaxPrice(_ value: Float){
        userSelectedMaxPrice = value
    }
    
    func getUserSelectedMaxPrice()-> Float{
         return userSelectedMaxPrice
    }
    
    func setNumberOfParticipants(_ value: Int){
        numberOfParticipants = value
    }
    
    func getNumberOfParticipants()-> Int{
         return numberOfParticipants
    }
    
    func setAceptedTC(_ value: Bool){
        aceptedTC = value
    }
    
    func getAceptedTC()-> Bool{
         return aceptedTC
    }
    
    func setSelectedPrice(_ value: Bool){
        selectedPrice = value
    }
    
    func getSelectedPrice()-> Bool{
         return selectedPrice
    }
    
}
