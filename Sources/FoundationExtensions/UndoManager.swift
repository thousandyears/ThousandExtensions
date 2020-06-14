//
//  UndoManager.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

import Foundation

public struct Edit<Of> where Of: AnyObject {
    
    public var undo: () -> Void
    
    public init<Value>(_ keyPath: ReferenceWritableKeyPath<Of, Value>, on root: Of, oldValue: Value) {
        undo = { root[keyPath: keyPath] = oldValue }
    }

    public static func willSet<Value>(_ keyPath: ReferenceWritableKeyPath<Of, Value>, on root: Of) -> Edit<Of> {
        .init(keyPath, on: root, oldValue: root[keyPath: keyPath])
    }
    
    public static func didSet<Value>(_ keyPath: ReferenceWritableKeyPath<Of, Value>, on root: Of, oldValue value: Value) -> Edit<Of> {
        .init(keyPath, on: root, oldValue: value)
    }

}

extension UndoManager {

    @inlinable public func registerWillSet<Root, Value>(of keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root, actionName: String? = nil)
        where Root: AnyObject
    {
        registerUndo(.willSet(keyPath, on: root), actionName: actionName)
    }
    
    @inlinable public func registerDidSet<Root, Value>(of keyPath: ReferenceWritableKeyPath<Root, Value>, on root: Root, oldValue value: Value, actionName: String? = nil)
        where Root: AnyObject
    {
        registerUndo(.didSet(keyPath, on: root, oldValue: value), actionName: actionName)
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
