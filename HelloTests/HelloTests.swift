import XCTest
@testable import Hello

final class HelloTests: XCTestCase {
    
    
    func testCartesian() throws {
        let triples = WaterColor.allCases.cartesianProduct(WaterColor.allCases).cartesianProduct(WaterColor.allCases)
        for element in triples {
            print(element.0.0.rawValue, element.0.1.rawValue, element.1.rawValue)
        }
    }
    
}

import Foundation

public extension Array {
    func cartesianProduct<RE>(_ rhs: Array<RE>) -> Array<(Self.Element, RE)> {
        var cartesian: Array<(Self.Element, RE)> = .init()
        
        for left in self {
            for right in rhs {
                cartesian.append((left, right))
            }
        }
        
        return cartesian
    }
}

public enum WaterColor: String, CaseIterable {
    case blue = "blue"
    case purple = "purple"
    case green = "green"
    case rainbow = "rainbow"
}
