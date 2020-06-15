//
//  PublishedEdit.swift
//  
//
//  Created by Oliver Atkinson on 15/06/2020.
//

import FoundationExtensions

@propertyWrapper
public struct PublishedEdit<Of> {
    
    public var wrappedValue: Of {
        didSet { wrappedValue$.send(wrappedValue) }
    }
    
    private let undoManager: UndoManager

    public init(wrappedValue: Of, using undoManager: UndoManager = .init()) {
        self.wrappedValue = wrappedValue
        self.undoManager = undoManager
    }

    public static subscript<Instance>(
        _enclosingInstance instance: Instance,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<Instance, Of>,
        storage storageKeyPath: ReferenceWritableKeyPath<Instance, Self>
    ) -> Of where Instance: AnyObject {
        get { instance[keyPath: storageKeyPath].wrappedValue }
        set {
            instance[keyPath: storageKeyPath].undoManager.registerUndo(of: wrappedKeyPath, on: instance)
            instance[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
    
    private let wrappedValue$: PassthroughSubject<Of, Never> = .init()
    public lazy var projectedValue: Publisher<Of, Never> = Publisher(wrappedValue$, undoManager)
    
    @dynamicMemberLookup
    public struct Publisher<Output, Failure>: Combine.Publisher where Failure : Error {
        
        private var publisher: AnyPublisher<Output, Failure>
        private var undoManager: UndoManager
        
        public init<P>(_ publisher: P, _ undoManager: UndoManager) where Output == P.Output, Failure == P.Failure, P: Combine.Publisher {
            self.publisher = AnyPublisher(publisher)
            self.undoManager = undoManager
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            publisher.receive(subscriber: subscriber)
        }
        
        subscript<Value>(dynamicMember keyPath: KeyPath<UndoManager, Value>) -> Value {
            undoManager[keyPath: keyPath]
        }
        
        // TODO: Delete this when we have KeyPath to instance members,
        // since it can be generically referenced using the dynamicMember subscript.
        func undo() { undoManager.undo() }
        func redo() { undoManager.redo() }
        func rollback() { undoManager.rollback() }
        
    }
    
}
