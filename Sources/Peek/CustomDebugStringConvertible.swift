extension CustomDebugStringConvertible {
    
    @inlinable
    @discardableResult
    public func peek(
        function: String = #function,
        file: String = #file,
        line: Int = #line,
        to log: ((Peek) -> ())? = nil
    ) -> Self {
        log?(Peek(self, \.self, nil, function, file, line))
        #if DEBUG
        print(Peek(self, \.self, nil, function, file, line))
        #endif
        return self
    }
    
    @inlinable
    @discardableResult
    public func peek<Property>(
        _ keyPath: KeyPath<Self, Property>,
        function: String = #function,
        file: String = #file,
        line: Int = #line,
        to log: ((Peek) -> ())? = nil
    ) -> Self {
        log?(Peek(self, keyPath, nil, function, file, line))
        #if DEBUG
        print(Peek(self, keyPath, nil, function, file, line))
        #endif
        return self
    }
    
    @inlinable
    @discardableResult
    public func peek<Message>(
        _ message: @autoclosure () -> Message,
        function: String = #function,
        file: String = #file,
        line: Int = #line,
        to log: ((Peek) -> ())? = nil
    ) -> Self {
        log?(Peek(self, \.self, message(), function, file, line))
        #if DEBUG
        print(Peek(self, \.self, message(), function, file, line))
        #endif
        return self
    }
    
    @inlinable
    @discardableResult
    public func peek<Message, Property>(
        _ message: @autoclosure () -> Message,
        _ keyPath: KeyPath<Self, Property>,
        function: String = #function,
        file: String = #file,
        line: Int = #line,
        to log: ((Peek) -> ())? = nil
    ) -> Self {
        log?(Peek(self, keyPath, message(), function, file, line))
        #if DEBUG
        print(Peek(self, keyPath, message(), function, file, line))
        #endif
        return self
    }
}

