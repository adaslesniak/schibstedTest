// ConvertibleNumber.swift [SwiftSugar] created by: Adas Lesniak on: 21/06/2018 
import Foundation
import CoreGraphics //for CGFloat


//simplifies all this casting in code from float to int and allows comprision of different number types
public protocol AnyNumber {
    init (_ value: Int)
    init (_ value: Float)
    init (_ value: Double)
    init (_ value: CGFloat)
}

extension CGFloat : AnyNumber {}
extension Double  : AnyNumber {}
extension Float   : AnyNumber {}
extension Int     : AnyNumber {}

extension AnyNumber {
    public func convert<T: AnyNumber>() -> T {
        switch self {
        case let nr as CGFloat:
            return T(nr)
        case let nr as Float:
            return T(nr)
        case let nr as Double:
            return T(nr)
        case let nr as Int:
            return T(nr)
        default:
            assert(false, "not implemented AnyNumber extension for \(type(of: self))")
            return T(0)
        }
    }
}

public func == <LHT:AnyNumber, RHT:AnyNumber>(lhs: LHT, rhs: RHT) -> Bool {
    let left: Double = lhs.convert()
    let right: Double = rhs.convert()
    return left == right
}

public func > <LHT:AnyNumber, RHT:AnyNumber>(lhs: LHT, rhs: RHT) -> Bool {
    let left: Double = lhs.convert()
    let right: Double = rhs.convert()
    return left > right
}

public func < <LHT:AnyNumber, RHT:AnyNumber>(lhs: LHT, rhs: RHT) -> Bool {
    let left: Double = lhs.convert()
    let right: Double = rhs.convert()
    return left < right
}

public func >= <LHT:AnyNumber, RHT:AnyNumber>(lhs: LHT, rhs: RHT) -> Bool {
    let left: Double = lhs.convert()
    let right: Double = rhs.convert()
    return left >= right
}

public func <= <LHT:AnyNumber, RHT:AnyNumber>(lhs: LHT, rhs: RHT) -> Bool {
    let left: Double = lhs.convert()
    let right: Double = rhs.convert()
    return left <= right
}
