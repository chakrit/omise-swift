import Foundation

public protocol Converter {
    associatedtype Target
    
    static func convertFromAttribute(_ value: Any?) -> Target?
    static func convertToAttribute(_ value: Target?) -> Any?
}
