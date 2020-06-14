@_exported import FoundationExtensions
@_exported import SKExtensions
@_exported import Periscope
@_exported import TrySwitch
@_exported import CombineExtensions

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
