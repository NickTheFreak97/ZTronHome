import SwiftUI

public final class HomePageModel: ObservableObject {
    @Published private var theGames: [String] = ["bo6", "mw3", "vanguard", "bocw", "bo4", "wwii", "iw", "bo3", "aw", "ghosts", "bo2", "bo", "waw"]
    @Published private var currentlyDraggingGame: String? = nil
    
    
    
    public final func setCurrentDraggingGame(_ game: String) {
        self.currentlyDraggingGame = game
    }
    
    public final func swapCurrentWith(_ other: String) {
        guard let currentGame = self.currentlyDraggingGame else { return }
        guard currentGame != other else { return }
        
        guard let startIndex = self.theGames.firstIndex(where: {
            return $0 == currentGame
        }) else { return }
        
        guard let destIndex = self.theGames.firstIndex(where: {
            return $0 == other
        }) else { return }
        
        var clone = [String].init()
        
        for game in self.theGames {
            clone.append(game)
        }
        
        clone.swapAt(startIndex, destIndex)
        
        withAnimation {
            self.theGames = clone
        }
    }
    
    public func getGames() -> [String] {
        var clone = [String].init()
        
        for game in self.theGames {
            clone.append(game)
        }
        
        return clone
    }
}
