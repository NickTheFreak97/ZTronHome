import Foundation

public protocol ZTronFiltrator {
    associatedtype T: Equatable
    
    func onFilterSelected(_: T) -> Void
    func onFilterDisabled(_: T) -> Void
    func getAllFilters() -> [T]
    func getActiveFilters() -> [T]
}
