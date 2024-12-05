import SwiftUI
import ZTronCarousel
import ZTronCarouselCore
import SwiftUIIntrospect


/// Test results:
/// 1. Replacing carousel component with any UIView instance doesn't trigger the animation glitch.
/// 2. Replacing carousel component with any UIViewController instance doesn't trigger the animation glitch
/// 3. Using the `Carousel16_9Page`, setting `.aspectRatio(16.0/9.0, contentMode: .fit)` modifier to the UIViewControllerRepresentable in SwiftUI stops the animation glitch
/// 4. Manipulation of UIViewController lifecycle methods is uneffective
/// 5. Removing carousel page from parent view controller and readding after completion doesn't fix the animation glitch.
struct ContentView: View {
    @State private var isPresenting: Bool = true
    
    public var body: some View {
        VStack(alignment: .leading) {
            CarouselCore()
                // .aspectRatio(16.0/9.0, contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView()
}


fileprivate struct Carousel: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CarouselPageWithTopbar {
        return CarouselPageWithTopbar(foreignKeys: .init(tool: "memory charms", tab: "side quests", map: "rave in the redwoods", game: "infinite warfare"), medias: [])
    }
    
    func updateUIViewController(_ uiViewController: CarouselPageWithTopbar, context: Context) {
        
    }
}

fileprivate struct CarouselCore: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let navController = UINavigationController(rootViewController:
            Carousel16_9Page(
                with: DefaultZTronMediaFactory(),
                medias: [
                    ZTronCarouselImageDescriptor(
                        assetName: "caves.recreational.area.sign.billiard.ball",
                        in: .main,
                        caption: "Nunc molestie sapien in justo sagittis, vitae sodales urna efficitur. Mauris rhoncus, lacus sit amet suscipit eleifend, lacus ligula interdum elit, non commodo risus tortor id urna. Nullam sed lacus euismod lacus euismod accumsan a id massa. Quisque a purus vitae diam vehicula auctor. Nulla vitae dolor urna. Suspendisse rhoncus pretium cursus. Etiam suscipit dolor augue, eu eleifend purus ullamcorper quis. Aenean sit amet urna id nibh aliquet vehicula nec quis risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in elementum dolor, non tempus sapien. Cras ornare efficitur dapibus.",
                        placeables: [
                            PlaceableOutlineDescriptor(
                                parentImage: "caves.recreational.area.sign.billiard.ball",
                                outlineAssetName: "caves.recreational.area.sign.billiard.ball.outline",
                                outlineBoundingBox: CGRect(
                                    x: 0.502604166666667, y: 0.555555555555556, width: 0.0125, height: 0.0222222222222222
                                ),
                                colorHex: "#FF0043",
                                opacity: 1.0,
                                isActive: true
                            )
                        ],
                        master: nil
                    ),
                    ZTronCarouselImageDescriptor(
                        assetName: "quickies.rave.area.billiard.ball",
                        in: .main,
                        caption: "Suspendisse aliquet dui eu neque euismod convallis. Pellentesque tristique justo non felis ullamcorper euismod. Suspendisse facilisis diam eu ultrices dapibus. Quisque lacinia euismod enim sed commodo. Nam eget elementum ipsum. Ut turpis magna, faucibus eget augue eget, venenatis bibendum dolor. Donec scelerisque, felis eget convallis pretium, risus dolor molestie neque, sit amet luctus eros nulla a enim. Nulla tempus non turpis vel venenatis.",
                        placeables: [
                            PlaceableOutlineDescriptor(
                                parentImage: "quickies.rave.area.billiard.ball",
                                outlineAssetName: "quickies.rave.area.billiard.ball.outline",
                                outlineBoundingBox: CGRect(
                                    x: 0.280729166666667, y: 0.609259259259259, width: 0.0104166666666667, height: 0.0166666666666667
                                ),
                                colorHex: "#FF0043",
                                opacity: 1.0,
                                isActive: true
                            ),
                        ],
                        master: nil
                    )
                ]
            )
        )
        
        navController.isNavigationBarHidden = true
        
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}

fileprivate struct CarouselComponentVR: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CarouselComponent {
        return CarouselComponent(
                with: BasicMediaFactory(),
                medias: [
                    ZTronImageDescriptor(assetName: "caves.recreational.area.sign.billiard.ball", in: .main),
                    ZTronImageDescriptor(assetName: "quickies.rave.area.billiard.ball", in: .main)
                ]
            )
    }
    
    func updateUIViewController(_ uiViewController: CarouselComponent, context: Context) {
        
    }
}

