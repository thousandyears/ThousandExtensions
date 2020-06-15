//
//  UndoManager.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

import Combine

public struct Edit<Of> where Of: AnyObject {
    public var undo: () -> Void
    public init<Value>(_ keyPath: ReferenceWritableKeyPath<Of, Value>, on root: Of, currentValue: Value) {
        undo = { root[keyPath: keyPath] = currentValue }
    }
    public static func edit<Value>(of keyPath: ReferenceWritableKeyPath<Of, Value>, on root: Of, value: Value? = nil) -> Edit<Of> {
        .init(keyPath, on: root, currentValue: value ?? root[keyPath: keyPath])
    }
}

extension UndoManager {

    @inlinable public func registerUndo<Root, Value>(of keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root, currentValue value: Value? = nil, actionName: String? = nil)
        where Root: AnyObject
    {
        registerUndo(
            .edit(of: keyPath, on: root, value: value),
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
