import Foundation

public class Int64Converter: Converter {
    public typealias Target = Int64
    
    public static func convertFromAttribute(_ value: NSObject?) -> Target? {
        guard let n = value as? NSNumber else { return nil }
        return n.int64Value
    }
    
    public static func convertToAttribute(_ value: Target?) -> NSObject? {
        guard let n = value else { return nil }
        return NSNumber(value: n)
    }
}
