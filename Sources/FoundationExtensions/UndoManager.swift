extension UndoManager {
    public static let system = UndoManager()
}

@propertyWrapper
public struct Undoable<Value> {
    
    public var wrappedValue: Value
    private let undoManager: UndoManager
    
    public init(wrappedValue: Value, using undoManager: UndoManager) {
        self.wrappedValue = wrappedValue
        self.undoManager = undoManager
    }
    
    public static subscript<Instance>(
        _enclosingInstance instance: Instance,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<Instance, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<Instance, Self>
    ) -> Value where Instance: AnyObject {
        get { instance[keyPath: storageKeyPath].wrappedValue }
        set {
            instance[keyPath: storageKeyPath].undoManager.registerUndo(withTarget: instance, handler: { $0[keyPath: wrappedKeyPath] = newValue })
            instance[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
    
}
