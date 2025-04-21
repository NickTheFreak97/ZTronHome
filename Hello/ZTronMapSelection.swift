import SwiftUI
import ExyteGrid
import FloatingButton
import UniformTypeIdentifiers

public struct ZTronMapSelection: View {
    private let maps = [
        "spaceland", "ritr", "ss", "aotrt", "bfb"
    ]
    
    public var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 30) {
                    Image("iw.text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width * 0.6)
                        .padding(.top, 30)
                    
                    ForEach(self.maps, id: \.self) { map in
                        VStack(alignment: .leading, spacing: 10) {
                            Image("iw.iw.\(map).banner")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    Image("iw.iw.\(map).text")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: .infinity)
                                        .padding(.vertical)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white.opacity(0.1), lineWidth: 2.0)
                                }
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.bottom, 30)
            }
        }
        .background(Color("brand.bg"))
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ZTronMapSelection()
}
