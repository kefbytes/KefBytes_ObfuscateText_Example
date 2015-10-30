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

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        simpleHash(constantPassword)
//        simpleHashWithSalt(constantPassword, className: constantClassName)
//        encryptDecryptTest()
        obfuscateWithClassName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func encryptDecryptTest() {
        let key = "bbC2H19lkVbQDfak" // length == 16
        let iv = "gqLOHUioQ0QjhuvI" // lenght == 16
        let encryptedPassword = try! constantPassword.aesEncrypt(key, iv: iv)
        let decryptedPassword = try! encryptedPassword.aesDecrypt(key, iv: iv)
        print(constantPassword) //string to encrypt
        print("encryptedPassword:\(encryptedPassword)")
        print("decryptedPassword:\(decryptedPassword)")
        print("\(constantPassword == decryptedPassword)")
    }
    
    func obfuscateWithClassName() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let superclass:AnyClass = appDelegate.superclass!
        let hashediv = (superclass.description().sha256())
        let index = hashediv.startIndex.advancedBy(16)
        let key = "hdwdygfeblb324r3"
        let iv = hashediv.substringToIndex(index)

        let encryptedPassword = try! constantPassword.aesEncrypt(key, iv: iv)
        let decryptedPassword = try! encryptedPassword.aesDecrypt(key, iv: iv)
        print("decrypted password equals constantPassword: \(constantPassword == decryptedPassword)")

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


