// CGRect+.swift [SwiftSugar] created by: Adas Lesniak on: 17/10/2018
import Foundation
import CoreGraphics

public extension CGRect {
    
    static func atZero(width: AnyNumber, height: AnyNumber) -> CGRect {
        return CGRect(x: 0, y: 0, width: width.convert(), height: height.convert())
    }
    
    static func atZero(_ size: CGSize) -> CGRect{
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
}
