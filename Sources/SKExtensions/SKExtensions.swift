#if os(macOS)
@_exported import Cocoa
#elseif os(iOS)
@_exported import UIKit
#endif

#if canImport(QuartzCore)
@_exported import QuartzCore
#endif

#if canImport(CoreImage)
@_exported import CoreImage
#endif

@_exported import FoundationExtensions
@_exported import CombineExtensions
@_exported import SpriteKit
@_exported import GameplayKit

// Try
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
