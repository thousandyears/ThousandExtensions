#if canImport(Cocoa)
import Cocoa
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(Cocoa)
public typealias Window = NSWindow
#elseif canImport(UIKit)
public typealias Window = UIWindow
#endif

#if os(macOS)
public typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
public typealias ViewRepresentable = UIViewRepresentable
#endif
