import Foundation

public class IntConverter: Converter {
    public typealias Target = Int
    
    public static func convertFromAttribute(_ value: NSObject?) -> Target? {
        guard let n = value as? NSNumber else { return nil }
        return n.intValue
    }
    
    public static func convertToAttribute(_ value: Target?) -> NSObject? {
        guard let n = value else { return nil }
        return NSNumber(value: n)
    }
}
