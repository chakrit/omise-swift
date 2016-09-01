import Foundation

public class DateConverter: Converter {
    public typealias Target = Date
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    public static func convertFromAttribute(_ value: Any?) -> Target? {
        guard let s = value as? String else { return nil }
        return formatter.date(from: s)
    }
    
    public static func convertToAttribute(_ value: Target?) -> Any? {
        guard let d = value else { return nil }
        return formatter.string(from: d)
    }
}
