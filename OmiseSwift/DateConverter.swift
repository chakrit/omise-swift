import Foundation

public class DateConverter: Converter {
    public typealias Target = Date
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    public static func convertFromAttribute(_ value: NSObject?) -> Target? {
        guard let s = value as? NSString else { return nil }
        return formatter.date(from: s as String)
    }
    
    public static func convertToAttribute(_ value: Target?) -> NSObject? {
        guard let d = value else { return nil }
        return formatter.string(from: d) as NSString
    }
}
