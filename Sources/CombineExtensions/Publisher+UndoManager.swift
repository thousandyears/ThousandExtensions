//
//  Publisher+UndoManager.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

import Periscope
import FoundationExtensions

extension Publisher where Failure == Never {
    
    @inlinable public func sink<Root: AnyObject, T>(
        to method: @escaping (Root) -> (T, T) -> Void,
        on root: Root
    ) -> AnyCancellable where Output == (newValue: T, oldValue: T) {
        sink{ [weak root] output in
            root.map(method)?(output.newValue, output.oldValue)
        }
    }
    
}

extension Publisher where Failure == Never {
    
    @inlinable public func previous(_ oldValue: Output) -> Publishers.Scan<Self, (newValue: Output, oldValue: Output)> {
        scan((newValue: oldValue, oldValue: oldValue), { ($1, $0.newValue) })
    }
    
    @inlinable public func registerUndo<Root, A>(of keyPath: ReferenceWritableKeyPath<Root, A>, on root: Root, using undoManager: UndoManager) -> AnyCancellable
        where Root: AnyObject, Output == (newValue: A, oldValue: A)
    {
        sink { [weak root, weak undoManager] value in
            guard let root = root, let undoManager = undoManager else { return }
            undoManager.registerDidSet(of: keyPath, on: root, oldValue: value.oldValue)
        }
    }
    
    @inlinable public func registerUndo<Root>(of keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root, using undoManager: UndoManager) -> AnyCancellable
        where Root: AnyObject
    {
        previous(root[keyPath: keyPath]).registerUndo(of: keyPath, on: root, using: undoManager)
    }
    
}
