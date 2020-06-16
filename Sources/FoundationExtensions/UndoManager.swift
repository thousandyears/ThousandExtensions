//
//  UndoManager.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

@propertyWrapper
public struct Restorable<Value> {
    
    public var wrappedValue: Value

    public init(wrappedValue: Value, using undoManager: UndoManager = .init()) {
        self.wrappedValue = wrappedValue
        self.projectedValue = undoManager
    }

    public static subscript<Instance>(
        _enclosingInstance instance: Instance,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<Instance, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<Instance, Self>
    ) -> Value where Instance: AnyObject {
        get { instance[keyPath: storageKeyPath].wrappedValue }
        set {
            instance[keyPath: storageKeyPath].projectedValue.registerUndo(of: wrappedKeyPath, on: instance)
            instance[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
    
    public var projectedValue: UndoManager
    
}

public struct Edit<Root> where Root: AnyObject {
    
    public var undo: () -> Void
    
    public init<Value>(_ keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root, currentValue: Value) {
        undo = { root[keyPath: keyPath] = currentValue }
    }

    public static func edit<Value>(_ keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root, value: Value? = nil) -> Edit<Root> {
        .init(keyPath, on: root, currentValue: value ?? root[keyPath: keyPath])
    }

}

extension UndoManager {

    @inlinable public func registerUndo<Root, Value>(of keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root, currentValue value: Value? = nil, actionName: String? = nil)
        where Root: AnyObject
    {
        registerUndo(
            .edit(keyPath, on: root, value: value),
            actionName: actionName
        )
    }

    public func registerUndo<Root>(_ edits: Edit<Root>..., actionName: String? = nil) {
        beginUndoGrouping()
        if let actionName = actionName {
            setActionName(actionName)
        }
        for handler in edits.map(handler) {
            registerUndo(withTarget: self, handler: handler)
        }
        endUndoGrouping()
    }
    
    private func handler<Root>(_ edit: Edit<Root>) -> (UndoManager) -> Void {
        return { _ in edit.undo() }
    }
    
    /// Removes everything from the undo stack, discards all insertions and deletions, and restores objects to their original values.
    public func rollback<Root>(root: Root) {
        removeAllActions(withTarget: root)
    }
    
    /// Removes everything from the undo stack, discards all insertions and deletions, and restores objects to their original values.
    public func rollback() {
        removeAllActions()
    }

}
