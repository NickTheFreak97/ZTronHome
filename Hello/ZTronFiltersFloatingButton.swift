import SwiftUI

public struct ZTronFiltersFloatingButton: View {
    @State private var isExpanded: Bool = false
    
    public var body: some View {
        HStack {
            if self.isExpanded {
                Group {
                    Text("Treyarch")
                        .foregroundStyle(Color(
                            red: 107.0/255.0,
                            green: 107.0/255.0,
                            blue: 107.0/255.0
                        ))

                    
                    Text("Infinity Ward")
                        .foregroundStyle(.accent)
                        .font(.callout.weight(.medium))
                        .frame(maxHeight: 48)
                        .background {
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
                        

                    Text("SHG")
                        .foregroundStyle(Color(
                            red: 107.0/255.0,
                            green: 107.0/255.0,
                            blue: 107.0/255.0
                        ))

                }
                .font(.callout)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .opacity(self.isExpanded ? 1.0 : 0.0)
                .frame(
                    maxWidth: self.isExpanded ? .infinity : .zero,
                    alignment: .center
                )
                .clipped()
                .transition(.slide.combined(with: .opacity))
                .animation(.spring(dampingFraction: 0.4), value: self.isExpanded)
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
            ZStack {
                Circle()
                    .fill(.accent)
                
                Text("2")
                    .foregroundStyle(Color("brand.bg"))
                    .font(.system(size: 10).weight(.black))
                
                Circle()
                    .stroke(Color("brand.bg"), lineWidth: 2)
            }
            .frame(width: 15, height: 15, alignment: .center)
            
        }
        .padding(.horizontal)
    }

    
}

#Preview {
    ZTronFiltersFloatingButton()
}
