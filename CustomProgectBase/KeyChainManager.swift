//
//  KeyChainManager.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/10/30.
//  Copyright © 2019 于晓杰. All rights reserved.
//

import UIKit

public class KeyChainManager {
    // 创建查询条件
    private class func createQuaryMutableDictionary(identifier: String) -> NSMutableDictionary{
        let keychainQuaryMutableDictionary = NSMutableDictionary.init(capacity: 0)
        keychainQuaryMutableDictionary.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrService as String)
        keychainQuaryMutableDictionary.setValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
        return keychainQuaryMutableDictionary
    }
    
    // 存储数据
    public class func keyChainSaveData(data: Any, withIdentifier identifier:String) -> Bool {
        let keyChainSaveMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 删除旧数据
        SecItemDelete(keyChainSaveMutableDictionary)
        // 设置数据
        keyChainSaveMutableDictionary.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        // 存储数据
        let saveState = SecItemAdd(keyChainSaveMutableDictionary, nil)
        if saveState == noErr  {
            return true
        }
        return false
    }
    
    // 更新数据
    public class func keyChainUpdata(data: Any, withIdentifier identifier:String) -> Bool {
        let keyChainUpdataMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 数据存储字典
        let updataMutableDictionary = NSMutableDictionary.init(capacity: 0)
        // 设置数据
        updataMutableDictionary.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        // 更新数据
        let updataStatus = SecItemUpdate(keyChainUpdataMutableDictionary, updataMutableDictionary)
        if updataStatus == noErr {
            return true
        }
        return false
    }
    
    // 获取数据
    public class func keyChainReadData(identifier: String) -> Any? {
        var idObject: Any?
        let keyChainReadmutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        keyChainReadmutableDictionary.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keyChainReadmutableDictionary.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        var queryResult: AnyObject?
        // 查询数据
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadmutableDictionary, UnsafeMutablePointer($0))}
        if readStatus == errSecSuccess {
            if let data = queryResult as! NSData? {
                idObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as Any
            }
        }
        return idObject
    }
    
    // 删除数据
    public class func keyChianDelete(identifier: String) -> Void {
        let keyChainDeleteMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 删除数据
        SecItemDelete(keyChainDeleteMutableDictionary)
    }
}
