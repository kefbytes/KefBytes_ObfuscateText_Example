//
//  ViewController.swift
//  ObfuscateText
//
//  Created by Franks, Kent on 10/29/15.
//  Copyright © 2015 Franks, Kent. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    
    let constantPassword = "Hanoah0325"
    let constantClassName = "ViewController"
    let authHeader = "SU9TQ29uc3VtZXJVc2VyOnFjdW93Zzdh"
    
    let key = "bbC2H19lkVbQDfak"
    var iv:String = ""
    var encryptedAuthHeader:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        simpleHash(constantPassword)
//        simpleHashWithSalt(constantPassword, className: constantClassName)
        
        encryptedAuthHeader = encryptString(authHeader)
        print("encryptedAuthHeader = \(encryptedAuthHeader!)")
        
        print("decrypted encryptedAuthHeader = \(decryptString(encryptedAuthHeader!))")
        print(authHeader == decryptString(encryptedAuthHeader!))
    }

    func simpleHash(password:String) {
        let hashedPassword = password.sha256()
        print("hashedPassword = \(hashedPassword)")
    }
    
    func simpleHashWithSalt(password:String, className:String) {
        let saltedPassword = className + password
        print("saltedPassword = \(saltedPassword)")
        
        let hashedSaltedPassword = saltedPassword.sha256()
        print("hashedSaltedPassword = \(hashedSaltedPassword)")
    }
    
    func encryptString(stringToEncrypt:String) -> String {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let superclass:AnyClass = appDelegate.superclass!
        let hashediv = (superclass.description().sha256())
        let index = hashediv.startIndex.advancedBy(16)
        let iv = hashediv.substringToIndex(index)
        return try! stringToEncrypt.aesEncrypt(key, iv: iv)
    }
    
    func decryptString(stringToDecrypt:String) -> String {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let superclass:AnyClass = appDelegate.superclass!
        let hashediv = (superclass.description().sha256())
        let index = hashediv.startIndex.advancedBy(16)
        let iv = hashediv.substringToIndex(index)
        return try! stringToDecrypt.aesDecrypt(key, iv: iv)
    }

}

import Foundation

extension String {
    func aesEncrypt(key: String, iv: String) throws -> String{
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let enc = try AES(key: key, iv: iv, blockMode:.CBC).encrypt(data!.arrayOfBytes(), padding: PKCS7())
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result
    }
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        let dec = try AES(key: key, iv: iv, blockMode:.CBC).decrypt(data!.arrayOfBytes(), padding: PKCS7())
        let decData = NSData(bytes: dec, length: Int(dec.count))
        let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
        return String(result!)
    }
}


