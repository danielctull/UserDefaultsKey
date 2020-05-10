
// On systems that can import Combine and SwiftUI the dynamic variant of the
// property wrapper is chosen otherwise the static version is used.

#if canImport(Combine) && canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public typealias UserDefault = DynamicUserDefault
#else
public typealias UserDefault = StaticUserDefault
#endif
