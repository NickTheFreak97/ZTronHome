import SwiftUI

struct DraggableHeader: View {
    @Environment(\.colorScheme) private var colorScheme
    private var image: String
    private var aspectRatio: CGFloat
    private var coordinateSpace: String
    
    init(image: String, aspectRatio: CGFloat, coordinateSpace: String) {
        self.image = image
        self.aspectRatio = aspectRatio
        self.coordinateSpace = coordinateSpace
    }
 
    var body: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .named(self.coordinateSpace)).minY
            let size = geo.size
            let height = size.width/self.aspectRatio + minY
            
            Image(self.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay {
                    LinearGradient(
                        colors: [.clear, Color("brand.bg")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .overlay(alignment: .top) {
                    Image("iw.shaolin.text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .frame(width: size.width, height: max(0, height), alignment: .top)
                .cornerRadius(1)
                .offset(y: -minY)

        }
        .frame(maxWidth: .infinity)
        .aspectRatio(self.aspectRatio, contentMode: .fit)
        .shadow(
            radius: 20,
            x: 0,
            y: 10
        )
    }}

struct DraggableHeader_Previews: PreviewProvider {
    static var previews: some View {
        DraggableHeader(
            image: "iw.shaolin.map.banner", aspectRatio: 2.08, coordinateSpace: "SCROLL_AOTRT_SWINGS")
    }
}
