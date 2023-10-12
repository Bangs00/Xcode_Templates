//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

public func customLog<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
#if DEBUG
	print("📓 LOG 📓")
	guard let object else {
		print("\(Date())\n\(filename.components(separatedBy: "/").last ?? "") / line \(line) / \(funcName)\n")
		return
	}
	print("\(Date())\n\(filename.components(separatedBy: "/").last ?? "") / line \(line) / \(funcName) : \(object)\n")
#endif
}

public func customLog(filename: String = #file, line: Int = #line, funcName: String = #function) {
#if DEBUG
	print("📓 LOG 📓")
	print("\(Date())\n\(filename.components(separatedBy: "/").last ?? "") / line \(line) / \(funcName)\n")
#endif
}

