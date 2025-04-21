import SwiftUI

public final class HomePageModel: ObservableObject, ZTronFiltrator {
    @Published private var theGames: [ZTronGameModel] = [
        ZTronGameModel(name: "bo6", position: 0, studio: "treyarch"),
        ZTronGameModel(name: "mw3", position: 1, studio: "infinity ward"),
        ZTronGameModel(name: "vanguard", position: 2, studio: "shg"),
        ZTronGameModel(name: "bocw", position: 3, studio: "treyarch"),
        ZTronGameModel(name: "bo4", position: 4, studio: "treyarch"),
        ZTronGameModel(name: "wwii", position: 5, studio: "shg"),
        ZTronGameModel(name: "iw", position: 6, studio: "infinity ward"),
        ZTronGameModel(name: "bo3", position: 7, studio: "treyarch"),
        ZTronGameModel(name: "ghosts", position: 8, studio: "shg"),
        ZTronGameModel(name: "aw", position: 9, studio: "infinity ward"),
        ZTronGameModel(name: "bo2", position: 10, studio: "treyarch"),
        ZTronGameModel(name: "bo", position: 11, studio: "treyarch"),
        ZTronGameModel(name: "waw", position: 12, studio: "treyarch")
    ]
    @Published private var currentlyDraggingGame: String? = nil
    private let filtersModel: ZTronFilterModel = .init(filters: ["infinity ward", "treyarch", "shg"])
    
    public final func setCurrentDraggingGame(_ game: ZTronGameModel) {
        self.currentlyDraggingGame = game.getName()
    }
    
    public final func swapCurrentWith(_ other: ZTronGameModel) {
        guard let currentGame = self.currentlyDraggingGame else { return }
        guard currentGame != other.getName() else { return }
        
        guard let startIndex = self.theGames.firstIndex(where: {
            return $0.getName() == currentGame
        }) else { return }
        
        guard let destIndex = self.theGames.firstIndex(where: {
            return $0 == other
        }) else { return }
        
        var clone = [ZTronGameModel].init()
        
        for game in self.theGames {
            clone.append(game)
        }
        
        clone.swapAt(startIndex, destIndex)
        
        withAnimation {
            self.theGames = clone
        }
    }
    
    public func getGames() -> [ZTronGameModel] {
        var clone = [ZTronGameModel].init()
        
        let activeFilters = self.filtersModel.getActiveFilters()
        
        for game in self.theGames {
            if activeFilters.contains(game.getStudio()) {
                clone.append(game)
            }
        }
        
        return clone
    }
    
    
    public func onFilterSelected(_ filter : String) {
        self.filtersModel.onFilterSelected(filter.lowercased())
        self.objectWillChange.send()
    }
    
    public func onFilterDisabled(_ filter: String) {
        self.filtersModel.onFilterDisabled(filter.lowercased())
        self.objectWillChange.send()
    }
    
    public func getAllFilters() -> [String] {
        return self.filtersModel.getAllFilters()
    }
    
    public func getActiveFilters() -> [String] {
        return self.filtersModel.getAllFilters()
    }
}
