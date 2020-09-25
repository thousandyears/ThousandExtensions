extension Collection where Element: Publisher {
    @inlinable public func merge() -> AnyPublisher<Element.Output, Element.Failure> {
        Publishers.MergeMany(self).eraseToAnyPublisher()
    }
}

extension Collection where Element: Publisher {
    @inlinable public func zip() -> AnyPublisher<[Element.Output], Element.Failure> {
        switch count {
        case 0: return Empty().eraseToAnyPublisher()
        case 1: return self[startIndex].map{ [$0] }.eraseToAnyPublisher()
        default: return self[startIndex].zip(dropFirst())
        }
    }
}
