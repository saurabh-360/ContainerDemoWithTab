//
//  RequestManager.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 13/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit

class RequestManager: NSObject {
    public static var shared = RequestManager()
}

// this is an extension to read and write from the json file
extension RequestManager {
    
    func returnJsonContents(filename : String, fileExtension : String) -> Any? {
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: fileExtension) {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    return object
                } else if let object = json as? [Any] {
                    // json is an array
                    return object
                } else {
                    print("JSON is invalid")
                    return nil
                    
                }
            } else {
                print("no file")
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func writeToFile(file : String, text : Data){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            //writing
            do {
                try text.write(to: path, options: [])
                return
            }
            catch {/* error handling here */
                print("could not write")
                return
            }
        }
    }
    
    func readJsonFile(file : String) -> Data? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            
            //reading
            do {
                let text2 = try Data.init(contentsOf: path)
                return text2
            }
            catch {/* error handling here */
                return nil
            }
        }
        return nil
    }
}
