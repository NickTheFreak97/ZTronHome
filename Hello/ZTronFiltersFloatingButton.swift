import SwiftUI

public struct ZTronFiltersFloatingButton: View {
    @State private var isExpanded: Bool = false
    private let filters: [String]
    @State private var activeFilters: [String] = []
    
    private var onFilterAddedAction: ((String) -> Void)?
    private var onFilterRemovedAction: ((String) -> Void)?
    
    public init(filters: [String]) {
        self.filters = filters
    }
    
    public var body: some View {
        HStack {
            if self.isExpanded {
                Group {
                    ForEach(self.filters, id: \.self) { filter in
                        Button {
                            if self.activeFilters.contains(filter) {
                                self.activeFilters.removeAll { other in
                                    return other == filter
                                }
                                self.onFilterRemovedAction?(filter)
                            } else {
                                self.activeFilters.append(filter)
                                self.onFilterAddedAction?(filter)
                            }
                        } label: {
                            Text(filter)
                                .lineLimit(1)
                                .allowsTightening(true)
                                .minimumScaleFactor(0.25)
                                .opacity(self.isExpanded ? 1.0 : 0.0)
                                .frame(
                                    maxWidth: self.isExpanded ? .infinity : .zero,
                                    alignment: .center
                                )
                                .frame(height: 48)
                                .clipped()
                                .transition(.slide.combined(with: .opacity))
                                .animation(.spring(dampingFraction: 0.4), value: self.isExpanded)
                                .foregroundStyle(
                                    self.activeFilters.contains(filter) ? .accent :
                                    Color(
                                        red: 107.0/255.0,
                                        green: 107.0/255.0,
                                        blue: 107.0/255.0
                                    )
                                )
                                .background {
                                    if self.activeFilters.contains(filter) {
                                        RadialGradient(
                                            colors: [
                                                .accentColor.opacity(0.1),
                                                .clear
                                            ],
                                            center: .center,
                                            startRadius: 0,
                                            endRadius: 50
                                        )
                                    }
                                }
                        }
                    }
                }
            }
            
            Button {
                withAnimation(.spring(bounce: 0.4)) {
                    self.isExpanded.toggle()
                }
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 20))
                    .frame(width: 48.0, height: 48.0)
                    .background {
                        Circle()
                            .fill(.accent.opacity(0.1))
                    }
                    .foregroundStyle(.accent)
            }
        }
        .padding(.leading)
        .clipShape(Capsule())
        .frame(
            minWidth: 48,
            maxWidth: .infinity,
            alignment: .trailing
        )
        .background(alignment: .trailing) {
            Capsule()
                .fill(
                    self.isExpanded ?
                        .accent.opacity(0.1) :
                        .clear
                )
                .frame(maxWidth:
                        self.isExpanded ? .infinity : 48
                )
                .frame(height: 48)
                .background(Color("brand.bg"))
                .clipShape(Capsule())
        }
        .overlay(alignment: .topTrailing) {
            if self.activeFilters.count > 0 {
                ZStack {
                    Circle()
                        .fill(.accent)
                    
                    Text("\(self.activeFilters.count)")
                        .foregroundStyle(Color("brand.bg"))
                        .font(.system(size: 10).weight(.black))
                    
                    Circle()
                        .stroke(Color("brand.bg"), lineWidth: 2)
                }
                .frame(width: 15, height: 15, alignment: .center)
            }
            
        }
        .padding(.horizontal)
    }

    public func onFilterAdded(_ perform: @escaping (String) -> Void) -> Self {
        var copy = self
        copy.onFilterAddedAction = perform
        return copy
    }
    
    public func onFilterRemoved(_ perform: @escaping (String) -> Void) -> Self {
        var copy = self
        copy.onFilterRemovedAction = perform
        return copy
    }
}

#Preview {
    ZTronFiltersFloatingButton(filters: ["Treyarch", "Infinity Ward", "SHG"])
}
