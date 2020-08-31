@_exported import FoundationExtensions
@_exported import SKExtensions
@_exported import Accelerate

// Peek
infix operator ¶ : TernaryPrecedence

// Try
infix operator ?= : AssignmentPrecedence

// Bool
infix operator &&= : AssignmentPrecedence
infix operator ||= : AssignmentPrecedence

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
