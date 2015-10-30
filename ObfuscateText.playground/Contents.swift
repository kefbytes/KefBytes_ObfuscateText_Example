//: Learn to ObfuscateText

import UIKit
import Security


var password = "hanoah0325"








/*: Original attempts below, but don't believe it's the way to go */
let passwordData = [UInt8](password.utf8)
let passwordDataLength = UInt(passwordData.count)

// encrypt
var encryptedData = [UInt8](count: Int(passwordDataLength), repeatedValue: 0)
var encryptedDataLength = passwordDataLength

var publicKey = [0xDE, 0xAD, 0xBE, 0xEF, 0xDE, 0xAD, 0xBE, 0xEF, 0xDE, 0xAD, 0xBE, 0xEF, 0xDE, 0xAD, 0xBE, 0xEF]

//var encryptedResult = SecKeyEncrypt(publicKey, SecPadding(1),
//    passwordData, passwordDataLength, &encryptedData, &encryptedDataLength)

// decrypt
var decryptedData = [UInt8](count: Int(passwordDataLength), repeatedValue: 0)
var decryptedDataLength = passwordDataLength

//var decryptedResult = SecKeyDecrypt(publicKey, SecPadding(1),
//    encryptedData, encryptedDataLength,
//    &decryptedData, &decryptedDataLength)

var passwordHashValue = password.hashValue

//extension String {
//    func sha1() -> String {
//        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
//        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
//        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joinWithSeparator("")
//    }
//}
