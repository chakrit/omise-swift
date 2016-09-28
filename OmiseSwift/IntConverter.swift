import Foundation

public class IntConverter: Converter {
    public typealias Target = Int
    
    public static func convertFromAttribute(_ value: Any?) -> Target? {
        guard let n = value as? Int else { return nil }
        return n
    }
    
    public static func convertToAttribute(_ value: Target?) -> Any? {
        guard let n = value else { return nil }
        return n
    }
}
