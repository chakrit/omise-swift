import Foundation

public enum ChargeStatus: String {
    case failed
    case reversed
    case pending
    case successful
}

/*
package omise

// ChargeStatus represents an enumeration of possible status of a Charge object, which
// can be one of the following list of constants:
type ChargeStatus string

const (
    ChargeFailed     ChargeStatus = "failed"
    ChargeReversed   ChargeStatus = "reversed"
    ChargePending    ChargeStatus = "pending"
    ChargeSuccessful ChargeStatus = "successful"
)
*/
