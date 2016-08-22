import Foundation

public class EnumConverter<TEnum: RawRepresentable>: Converter where TEnum.RawValue == String {
    public typealias Target = TEnum
    
    public static func convertFromAttribute(_ value: NSObject?) -> Target? {
        guard let s = value as? String else { return nil }
        return TEnum(rawValue: s)
    }
    
    public static func convertToAttribute(_ value: Target?) -> NSObject? {
        guard let v = value else { return nil }
        return v.rawValue as NSString
    }
}
