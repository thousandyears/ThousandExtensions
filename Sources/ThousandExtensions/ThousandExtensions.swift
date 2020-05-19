@_exported import FoundationExtensions
@_exported import SKExtensions
@_exported import Periscope
@_exported import TrySwitch

#if canImport(Cocoa)
@_exported import CocoaExtensions
#endif

// TrySwitch
infix operator ?= : AssignmentPrecedence

// DictionaryArithmetic
infix operator .+ : AdditionPrecedence
infix operator .- : AdditionPrecedence
infix operator .* : MultiplicationPrecedence
infix operator ./ : MultiplicationPrecedence

infix operator .+= : AssignmentPrecedence
infix operator .-= : AssignmentPrecedence
infix operator .*= : AssignmentPrecedence
infix operator ./= : AssignmentPrecedence

// Space
infix operator ± : RangeFormationPrecedence
infix operator ±= : AssignmentPrecedence
