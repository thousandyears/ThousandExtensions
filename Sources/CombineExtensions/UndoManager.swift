import class Foundation.UndoManager

extension UndoManager {
    
    public func observingChanges<Root, Value, Publisher>(
        of keyPath: ReferenceWritableKeyPath<Root, Value>,
        on root: Root,
        publisher: Publisher
    ) -> AnyCancellable where Root: AnyObject, Publisher: Combine.Publisher, Publisher.Output == Value, Publisher.Failure == Never {
        observingChanges(of: keyPath, on: root, publisher: publisher.eraseToAnyPublisher())
    }

    public func observingChanges<Root, Value>(
        of keyPath: ReferenceWritableKeyPath<Root, Value>,
        on root: Root,
        publisher: AnyPublisher<Value, Never>
    ) -> AnyCancellable where Root: AnyObject {
        return publisher.sink { [weak self, weak root] value in
            guard let self = self else { return }
            guard let root = root else { return }
            self.registerUndo(withTarget: root) { root in root[keyPath: keyPath] = value }
        }
    }
    
}
