import SwiftUI
import ExyteGrid


public struct TrolltasticView: View {
    @State private var currentPage: Int = 0
    public var body: some View {

        // WINDOW 1: {[0,0], [0, 1], [1, 1], [2,1], [3, 0], [3, 1], [3, 2]} 4x3  SPELLS 1
        // WINDOW 2: {[0,0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 2], [3, 0], [3, 2], [4, 2], [5, 0], [5, 1], [5, 2]} 6x3 SPELLS 9
        // WINDOW 3: {[1,1], [1, 2], [1, 3], [1, 4], [1, 5],  [2, 5], [3, 4], [4, 3], [5, 3], [6, 3], [7, 3]}  7x9 SPELLS 7
        // WINDOW 4: {[0,0], [0, 1], [0, 2], [1, 2], [2, 0], [2, 1], [2, 2], [3,0], [4, 0], [5, 0], [5, 1], [5, 2] }  6x3 SPELLS 2
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<4, id: \.self) { _ in
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<3, id: \.self) { _ in
                        Image("concrete1")
                            .aspectRatio(0.55, contentMode: .fit)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Billion Dollar Treasure Hunt")
    }
}
