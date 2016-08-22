import Foundation

public protocol Converter {
    associatedtype Target
    
    static func convertFromAttribute(_ value: NSObject?) -> Target?
    static func convertToAttribute(_ value: Target?) -> NSObject?
}
