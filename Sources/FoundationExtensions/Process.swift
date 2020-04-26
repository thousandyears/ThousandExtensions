@available(OSX 10.13, *)
extension Process {
    
    public enum Command: String {
        case open = "/usr/bin/open"
        case screencapture = "/usr/sbin/screencapture"
    }
    
    @inlinable
    public static func run(
        _ command: Command,
        _ arguments: String...,
        handler: @escaping (Process) -> () = { _ in }
    ) throws {
        try run(command.rawValue, arguments, handler: handler)
    }
    
    @inlinable
    public static func run(
        _ command: Command,
        _ arguments: [String],
        handler: @escaping (Process) -> () = { _ in }
    ) throws {
        try run(command.rawValue, arguments, handler: handler)
    }

    @inlinable
    public static func run(
        _ command: String,
        _ arguments: String...,
        handler: @escaping (Process) -> () = { _ in }
    ) throws {
        try run(command, arguments, handler: handler)
    }
    
    public static func run(
        _ command: String,
        _ arguments: [String],
        handler: @escaping (Process) -> () = { _ in }
    ) throws {
        let o = Process()
        o.launchPath = command
        o.arguments = arguments
        o.terminationHandler = handler
        try o.run()
    }
}

