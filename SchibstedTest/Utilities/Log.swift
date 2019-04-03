// Log.swift [SchibstedTest] created by: Adas Lesniak on: 03/04/2019
import Foundation


//TODO: implement me! - this is just scaffolding
//TODO: add channels
public class Log {
    
    public static func error(_ message: String, file: String = #file, line: UInt = #line, function: String = #function) {
        let fromWhere = formatStackDetails(file, ln: line, func: function)
        print("ERROR: \(message)  \(fromWhere)")
    }
    
    public static func debug(_ message: String) {
        print(message)
    }
    
    public static func warning(_ message: String, file: String = #file, line: UInt = #line, function: String = #function) {
        let fromWhere = formatStackDetails(file, ln: line, func: function)
        print("Warning! - \(message)  \(fromWhere)")
    }
    
    private static func formatStackDetails(_ file: String, ln line: UInt, func function: String) -> String {
        var className = file
        if let iSlash = className.lastIndex(of: "/") {
            className = String(file[iSlash..<className.endIndex])
            className = className.replacingOccurrences(of: "/", with: "") //that's ugly - should just increase index
        }
        //var className = (file as NSString).lastPathComponent
        if let iExtension = className.firstIndex(of: ".") {
            className = String(className[..<iExtension])
        }
        var funcName = function
        if let iParams = funcName.firstIndex(of: "(") {
            funcName = String(funcName[..<iParams])
        }
        return "[at: \(className).\(funcName) ln:\(line)]"
    }
}
