import Foundation

public final class ZTronGameModel: Sendable, Hashable {
    public static func == (lhs: ZTronGameModel, rhs: ZTronGameModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    private let name: String
    private let position: Int
    private let studio: String
    
    
    public init(name: String, position: Int, studio: String) {
        self.name = name
        self.position = position
        self.studio = studio
    }
    
    public final func getName() -> String {
        return self.name
    }
    
    public final func getPosition() -> Int {
        return self.position
    }
    
    public final func getStudio() -> String {
        return self.studio
    }
    
    public final func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}
