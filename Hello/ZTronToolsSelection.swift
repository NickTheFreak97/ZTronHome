import SwiftUI
import Lottie

public struct ZTronToolsSelection: View {
    @State private var animationAmount: CGFloat = 1

    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    DraggableHeader(
                        image: "iw.shaolin.map.banner",
                        aspectRatio: 430.0/163.0,
                        coordinateSpace: "toolsPage"
                    )
                    .padding(.bottom, 15)
                    
                    ForEach(["Easter Eggs", "Skull Breaker", "Side Quests", "Music"], id: \.self) { quest in
                        VStack(alignment: .leading, spacing: 20) {
                            HStack(alignment: .center, spacing: 15) {
                                Text("\(quest)")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(.white)
                                
                                let difficulty = Int.random(in: 1...3)
                                
                                HStack(alignment: .center, spacing: 5) {
                                    ForEach(1..<4) { i in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(i <= difficulty ?
                                                .accent :
                                                Color(
                                                    red: 107.0/255.0,
                                                    green: 107.0/255.0,
                                                    blue: 107.0/255.0
                                                )
                                            )
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 80)),
                                GridItem(.adaptive(minimum: 80)),
                                GridItem(.adaptive(minimum: 80)),
                                GridItem(.adaptive(minimum: 80)),
                            ], spacing: 25) {
                                ForEach(Array([
                                    "iw.shaolin.easter.egg.call.box",
                                    "iw.shaolin.easter.egg.nightmare.summer",
                                    "iw.shaolin.easter.egg.rat.king.eye",
                                    "iw.shaolin.easter.egg.mahjong.tiles",
                                ].enumerated()), id: \.offset) { _, game in
                                    VStack(alignment: .center, spacing: 12) {
                                        Circle()
                                            .stroke(
                                                Color(
                                                    red: 217.0/255.0,
                                                    green: 217.0/255.0,
                                                    blue: 217.0/255.0
                                                ),
                                                lineWidth: 1.0
                                            )
                                            .frame(width: 72.0, height: 72.0)
                                            .overlay {
                                                Image(game)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 62, height: 62)
                                                    .clipShape(Circle())
                                            }
                                            .shadow(radius: 10)
                                            .overlay(alignment: .topTrailing) {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color.accentColor.opacity(0.1))
                                                    
                                                    Circle()
                                                        .fill(Color("brand.bg").opacity(0.9))
                                                    
                                                    Circle()
                                                        .stroke(
                                                            Color(
                                                                red: 217.0/255.0,
                                                                green: 217.0/255.0,
                                                                blue: 217.0/255.0
                                                            ),
                                                            lineWidth: 0.3
                                                        )
                                                    
                                                    Image(systemName: "photo.fill")
                                                        .resizable()
                                                        .foregroundStyle(Color.accentColor)
                                                        .frame(width: 10, height: 10)
                                                }
                                                .frame(width: 22, height: 22)
                                            }
                                        
                                        Text(game)
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 72.0)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("brand.bg"))
        .navigationBarTitleDisplayMode(.inline)
        .coordinateSpace(name: "toolsPage")
    }
}


#Preview {
    ZTronToolsSelection()
}
