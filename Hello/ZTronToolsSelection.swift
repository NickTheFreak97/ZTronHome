import SwiftUI
import Lottie

public struct ZTronToolsSelection: View {
    @Environment(\.verticalSizeClass) private var vSizeClass
    
    private let tools: [String] = [
        "iw.shaolin.easter.egg.call.box",
        "iw.shaolin.easter.egg.nightmare.summer",
        "iw.shaolin.easter.egg.rat.king.eye",
        "iw.shaolin.easter.egg.mahjong.tiles",
    ]
    
    @ObservedObject private var sectionFiltrersModel: ZTronFilterModel<String>
    
    public init(_ filtersModel: ZTronFilterModel<String>) {
        self._sectionFiltrersModel = ObservedObject(wrappedValue: filtersModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    if self.vSizeClass == .regular {
                        DraggableHeader(
                            image: "iw.iw.ss.banner",
                            aspectRatio: 430.0/163.0,
                            coordinateSpace: "toolsPage"
                        )
                        .padding(.bottom, 15)
                    }
                    
                    ForEach(self.sectionFiltrersModel.getActiveFilters(), id: \.self) { quest in
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
                                                        
                            LazyVGrid(
                                columns: Array(
                                            repeating: GridItem(.adaptive(minimum: 80)),
                                            count: min(
                                                Int(ceil(geo.size.width / (80.0 + 20.0))) - 1,
                                                self.tools.count
                                            )
                                        )
                                , spacing: 25
                            ) {
                                ForEach(Array(self.tools.enumerated()), id: \.offset) { _, game in
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
                                                    if Int.random(in: 0...1) == 0 {
                                                        Circle()
                                                            .fill(Color.accentColor.opacity(0.1))
                                                        
                                                        Circle()
                                                            .fill(Color("brand.bg").opacity(0.9))
                                                        
                                                        Circle()
                                                            .stroke(
                                                                Color.accentColor,
                                                                lineWidth: 0.3
                                                            )
                                                        
                                                        Image(systemName: "photo.fill")
                                                            .resizable()
                                                            .foregroundStyle(Color.accentColor)
                                                            .frame(width: 10, height: 10)
                                                    } else {
                                                        Seal()
                                                            .fill(Color.accentColor)
                                                        
                                                        Seal()
                                                            .stroke(
                                                                .black,
                                                                lineWidth: 1
                                                            )
                                                        
                                                        Image(systemName: "wrench.and.screwdriver.fill")
                                                            .resizable()
                                                            .foregroundStyle(Color("brand.bg"))
                                                            .frame(width: 10, height: 10)
                                                        
                                                    }
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
                        .background(Color("brand.bg"))
                    }
                }
                .padding(.bottom ,20)
                .aspectRatio(geo.size.width / geo.size.height, contentMode: .fit)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("brand.bg"))
        .navigationBarTitleDisplayMode(.inline)
        .coordinateSpace(name: "toolsPage")
        .overlay(alignment: .bottomTrailing) {
            ZTronFiltersFloatingButton(filters: self.sectionFiltrersModel.getAllFilters())
                .onFilterAdded { filter in
                    withAnimation {
                        self.sectionFiltrersModel.onFilterSelected(filter)
                    }
                }
                .onFilterRemoved { filter in
                    withAnimation {
                        self.sectionFiltrersModel.onFilterDisabled(filter)
                    }
                }
                .padding(.bottom)
        }

    }
    
}


#Preview {
    ZTronToolsSelection(.init(filters: ["Easter egg", "Skull breaker", "Side quests", "Music"]))
}
