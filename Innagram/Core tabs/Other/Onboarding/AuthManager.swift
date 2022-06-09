//
//  AuthManager.swift
//  Innagram
//
//  Created by YANA on 07/11/2021.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // public functions
    public func registerNewUser(username:String,email:String, password:String, completion: @escaping (Bool) -> Void){
        //check if username is avalable
        //check if email is avable
        
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username){
            canCreate in
            if canCreate{
                //create account
                // insert acc to database
                Auth.auth().createUser(withEmail: email, password: password){
                    result, error in
                  guard error == nil, result != nil else {
                      // firebase auth could not create an account
                      completion(false)
                        return
                    }
                    //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username){
                        inserted in
                        if inserted {
                            completion(true)
                            return
                        } else{
                            //Failed insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUsed(username: String?,email:String?,password:String , completion: @escaping (Bool) -> Void){
        if let email = email{
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in
                guard authResult != nil , error == nil else {
                   completion (false)
                    return
                }
                completion (true)
            }
        }
        else if let username = username{
            print(username)
        }
    }
    ///Attempt to logout firebase user
    public func logOut(completion: (Bool) -> Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            completion(false)
            print(error)
            return
        }
    }
}
