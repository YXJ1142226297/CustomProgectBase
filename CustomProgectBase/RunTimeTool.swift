//
//  RunTimeTool.swift
//  MobileProgect
//
//  Created by csqiuzhi on 2019/5/5.
//  Copyright © 2019 于晓杰. All rights reserved.
//
import UIKit

public protocol RunTimeProtocol: class {
    static func appAwake()
}

public class RunTimeTool {
    public static func getAllRunClass() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? RunTimeProtocol.Type)?.appAwake()
        }
        types.deallocate()
    }
}
