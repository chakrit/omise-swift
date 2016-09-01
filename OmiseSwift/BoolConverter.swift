import Foundation

public class BoolConverter: Converter {
    public typealias Target = Bool
    
    public static func convertFromAttribute(_ value: Any?) -> Target? {
        guard let n = value as? Bool else { return nil }
        return n
    }
    
    public static func convertToAttribute(_ value: Target?) -> Any? {
        guard let b = value else { return nil }
        return b
    }
}
