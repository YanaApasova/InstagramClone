//
//  Database.swift
//  Innagram
//
//  Created by YANA on 07/11/2021.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database(url: "https://innagram-71ef8-default-rtdb.europe-west1.firebasedatabase.app").reference()
   
    
   ///Check if username and email is avalable
    ///parameters
    ///-email:String representig email
    ///-username:String representid username
    public func canCreateNewUser(with email:String, username:String, completion: (Bool) -> Void){
        completion (true)
    }
    
    ///insert new user to database
    ///-Parametrs
    ///-email:String representing email
    ///-username:String representig username
    ///completion:async calllback for result if database entry succeded
    
    public func insertNewUser(with email:String, username:String, completion: @escaping (Bool)-> Void){
        database.child(email.safeDatabaseKey()).setValue(["username":username], withCompletionBlock: {
            error, _ in
            if error == nil{
                //succeeded
                completion (true)
                return
            }
            else{
                //failed
                completion(false)
                return
            }
        })
    }
    
  
}
