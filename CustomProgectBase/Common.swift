//
//  Common.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/4/30.
//  Copyright © 2019 于晓杰. All rights reserved.
//
import UIKit
import Security

public let ScreenWidth = UIScreen.main.bounds.size.width
public let ScreenHeight = UIScreen.main.bounds.size.height

public let SystemVersion = (UIDevice.current.systemVersion as NSString).floatValue

public let IPhoneX = ScreenHeight == 812.0
public let TABBAR_HEIGHT: CGFloat = IPhoneX ? (49.0 + 34.0) : 49.0
public let SATE_HEIGHT: CGFloat = IPhoneX ? 44.0 : 20.0
public let STATE_NAVIGATION_BAR_HEIGHT: CGFloat = IPhoneX ? 88.0 : 64.0
public let NAV_HEIGHT: CGFloat = 44.0
public let SAFE_HEIGHT: CGFloat = IPhoneX ? 34.0 : 0.0

public let MainURL = ""
public let APPVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
public let ProgectName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

//设备ID
public var UUID: String {
    get {
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
        return (strRef! as String).replacingOccurrences(of: "-", with: "")
    }
}
public var DeviceID: String {
    get {
        let deviceID = KeyChainManager.keyChainReadData(identifier: ProgectName)
        if deviceID == nil {
            let _ = KeyChainManager.keyChainSaveData(data: UUID, withIdentifier: ProgectName)
            return KeyChainManager.keyChainReadData(identifier: ProgectName) as! String
        }
        return deviceID as! String
    }
}

/// 图片宽高比
///
/// - Parameter imgStr: 图片名称
/// - Returns: 宽高比
public func ImageRote(_ imgStr: String!) -> CGFloat {
    let img = UIImage.init(named: imgStr)
    return img!.size.width / img!.size.height
}

/// 字体大小
///
/// - Parameters:
///   - fontSize: 字体大小
///   - bold: 是否加粗
/// - Returns: 最终字体
public func Font(_ fontSize: CGFloat, bold: Bool = false) -> UIFont {
    let lastFontSize = ScreenWidth == 414.0 ? fontSize : (ScreenWidth == 320.0 ? fontSize - 1 : fontSize + 1)
    return bold ? UIFont.boldSystemFont(ofSize: lastFontSize) : UIFont.systemFont(ofSize: fontSize)
}

/// 尺寸
///
/// - Parameter value: 传入尺寸
/// - Returns: 最终尺寸
public func RealValue(_ value: CGFloat) -> CGFloat {
    return max(0, value / 414.0 * ScreenWidth )
}

/// 自定义Log
///
/// - Parameters:
///   - message: 打印信息
///   - file: 文件
///   - funcName: 方法名
///   - lineNum: 行数
public func MyLog<T>(message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("""
        [行数:\(lineNum)]:[文件名:\(fileName)]:--打印内容:
        .................................................
        \(message)
        """)
    #endif
}

