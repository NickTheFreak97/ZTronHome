import SwiftUI

@main
struct HelloApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Buried Maze")
            }
            .navigationViewStyle(.stack)

        }

    }
}
