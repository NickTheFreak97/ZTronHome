import SwiftUI

public final class ZTronFilterModel<T: Equatable>: ObservableObject {
    private let allFilters: [T]
    @Published private var activeFilters: [T]
    
    public init(filters: [T]) {
        var clone = [T].init()
        
        for filter in filters {
            clone.append(filter)
        }
        
        self.allFilters = clone
        self.activeFilters = []
    }
    
    public final func onFilterSelected(_ filter: T) {
        guard self.allFilters.contains(filter) else { return }
        guard !self.activeFilters.contains(filter) else { return }
        
        var clone: [T] = []
        
        for other in self.activeFilters {
            clone.append(other)
        }
        
        clone.append(filter)

        clone = clone.sorted { lhs, rhs in
            guard let indexOfLHS = self.allFilters.firstIndex(of: lhs),
                  let indexOfRHS = self.allFilters.firstIndex(of: rhs) else { fatalError() }
            return indexOfLHS < indexOfRHS
        }
        
        self.activeFilters = clone
    }
    
    public final func onFilterDisabled(_ filter: T) {
        self.activeFilters.removeAll { other in
            return filter == other
        }
    }
    
    public final func getAllFilters() -> [T] {
        var clone = [T].init()
        
        for section in self.allFilters {
            clone.append(section)
        }
        
        return clone
    }
    
    public final func getActiveFilters() -> [T] {
        var clone = [T].init()
        
        for filter in self.activeFilters {
            clone.append(filter)
        }
        
        if clone.isEmpty {
            for filter in self.allFilters {
                clone.append(filter)
            }
        }
        
        return clone
    }

}
