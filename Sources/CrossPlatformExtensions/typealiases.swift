#if canImport(Cocoa)
import Cocoa
#elseif canImport(UIKit)
import UIKit
#elseif canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(Cocoa)
public typealias Window = NSWindow
#elseif canImport(UIKit)
public typealias Window = UIWindow
#endif
