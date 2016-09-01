import Foundation

public class StringConverter: Converter {
    public typealias Target = String
    
    public static func convertFromAttribute(_ value: Any?) -> Target? {
        return value as? String
    }
    
    public static func convertToAttribute(_ value: Target?) -> Any? {
        return value
    }
}
