import Foundation

public let centBasedCurrencyFactor = 100
public let identicalBasedCurrencyFactor = 1

public enum Currency {
    case thb
    case jpy
    case custom(code: String, numberOfFractionDigits: Int, factor: Int)
    
    
    public var code: String {
        switch self {
        case .thb:
            return "THB"
        case .jpy:
            return "JPY"
        case.custom(code: let code, numberOfFractionDigits: _, factor: _):
            return code
        }
    }
    
    public var symbol: String {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code) ?? ""
    }
    
    public var numberOfFractionDigits: Int {
        switch self {
        case .thb:
            return 2
        case .jpy:
            return 0
        case .custom(code: _, numberOfFractionDigits: let numberOfFractionDigits, factor: _):
            return numberOfFractionDigits
        }
    }
    
    /// A convertion factor represents how much Omise amount equals to 1 unit of this currency. eg. THB's factor is equals to 100.
    public var factor: Int {
        switch self {
        case .thb:
            return centBasedCurrencyFactor
        case .jpy:
            return identicalBasedCurrencyFactor
        case .custom(code: _, numberOfFractionDigits: _, factor: let factor):
            return factor
        }
    }
    
    public func convert(fromSubunit value: Int64) -> Double {
        return Double(value) / Double(factor)
    }
    
    public func convert(toSubunit value: Double) -> Int64 {
        return Int64(value * Double(factor))
    }
    
    public init?(code: String) {
        switch code.uppercased() {
        case "THB":
            self = .thb
        case "JPY":
            self = .jpy
        default: return nil
        }
    }
}
