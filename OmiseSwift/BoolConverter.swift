import Foundation

public class BoolConverter: Converter {
    public typealias Target = Bool
    
    public static func convertFromAttribute(_ value: NSObject?) -> Target? {
        guard let n = value as? NSNumber else { return nil }
        return n.boolValue
    }
    
    public static func convertToAttribute(_ value: Target?) -> NSObject? {
        guard let b = value else { return nil }
        return NSNumber(value: b)
    }
}
