import SwiftUI
import ExyteGrid
import FloatingButton
import UniformTypeIdentifiers

public struct ZTronHome: View {
    @FocusState private var focusedField: FocusField?

    @Environment(\.verticalSizeClass) private var vSizeClass
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    @Binding private var viewportWidth: CGFloat?
    
    @State private var showSearchOverlay: Bool = false
    @State private var searchText: String = ""

    @ObservedObject private var model: HomePageModel
    
    private let tallImageAR: CGFloat
    private let isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    private var vTracks: Int {
        return UIDevice.current.userInterfaceIdiom == .pad ? self.hSizeClass == .regular ? 3 : 2 : 2
    }
    
    private var hTracks: Int {
        return UIDevice.current.userInterfaceIdiom == .pad ? 4 : 3
    }

    
    public init(
        model: HomePageModel,
        viewportWidth: Binding<CGFloat?>
    ) {
        self._viewportWidth = viewportWidth
        self._model = ObservedObject(wrappedValue: model)
        
        let image = UIImage(named: "bo2.game.logo")!
        self.tallImageAR = image.size.width / image.size.height
    }
    
    private var spacing: CGFloat {
        return self.vSizeClass == .regular ? 20 : 20
    }
    
    
    public var body: some View {
        GeometryReader { geo in            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .center, spacing: 15) {
                        Text("Scroll down to search")
                            .font(.footnote)
                            .foregroundStyle(Color("AccentColor"))
                        
                        Image(systemName: "chevron.up")
                            .font(.system(size: 10))
                            .foregroundStyle(Color("AccentColor"))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background {
                        Capsule()
                            .fill(Color("AccentColor").opacity(0.15))
                            .blur(radius: 20)
                            .frame(maxWidth: self.viewportWidth != nil ? self.viewportWidth! / 2.0 : .infinity)
                            .offset(y: -20)
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pick Your Game, Find The Easter Eggs!")
                            .font(.title.weight(.bold))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                        HStack {
                            Spacer()
                            Text("Select your Call of Duty game and press to begin the hunt for hidden Easter eggs.")
                                .font(.caption)
                                .gradientForeground(colors: [Color("SunsetHorizon"), Color("SunsetSky")])
                                .multilineTextAlignment(.center)
                                .frame(
                                    maxWidth: self.viewportWidth != nil ? self.viewportWidth! * 0.7 : .infinity,
                                    alignment: .center
                                )
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    let theGrid = ZTronGrid(
                        data: self.model.getGames(),
                        pageSize: geo.size
                    ) { game, _ in
                        Image("\(game.getName()).game.logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                LinearGradient(
                                    colors: [.clear, .black],
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                            .overlay(alignment: .bottom) {
                                Image("\(game.getName()).text")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white.opacity(0.1), lineWidth: 2.0)
                            }
                            .overlay {
                                ZStack {
                                    if game.getName() == "waw" || game.getName() == "ghosts" || game.getName() == "mw3" {
                                        BackdropBlurView(radius: 5)
                                            .saturation(0.1)
                                        Image("zombietron.redacted")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                            .frame(
                                                maxWidth: .infinity,
                                                maxHeight: .infinity,
                                                alignment: .center
                                            )
                                    }
                                }
                            }
                            .onDrag {
                                self.model.setCurrentDraggingGame(game)
                                return NSItemProvider(item: String(describing: game.getName()) as NSString, typeIdentifier: "public.plain-text")
                            }
                            .onDrop(of: [UTType.text], delegate: HomePageDragDropDelegate(dragging: game, model: self.model))
                        
                    }
                    
                    Group {
                        if self.isIpad {
                            if hSizeClass == .compact {
                                theGrid
                                    .fitElementsInPage(targetElementsPerPage: 4)
                                    .withTracks(geo.size.width < 400 ? 1 : 2)
                            } else {
                                theGrid
                                    .fitWidth(targetAspectRatio: self.tallImageAR)
                                    .withTracks(4)
                            }
                        } else {
                            if self.vSizeClass == .regular {
                                theGrid
                                    .fitElementsInPage(
                                        targetElementsPerPage: geo.size.height < 600 ? 2.5 : 3
                                    )
                            } else {
                                theGrid
                                    .fitWidth(targetAspectRatio: self.tallImageAR)
                                    .withTracks(3)
                            }
                        }
                    }
                }
            }
            .refresher {
                withAnimation(.easeOut) {
                    self.showSearchOverlay = true
                }
            }
            .onDisappear {
                self.searchText = ""
                self.showSearchOverlay = false
            }
            .overlay(alignment: .center) {
                // MARK: - THE SEARCHBAR
                if self.showSearchOverlay {
                    ZStack(alignment: .topLeading) {
                        BackdropBlurView(radius: 10)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .onTapGesture {
                                withAnimation {
                                    self.showSearchOverlay.toggle()
                                }
                            }
                            .ignoresSafeArea(.all, edges: .all)
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .center, spacing: 10) {
                                HStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 24))
                                        .padding(.leading)
                                        .foregroundStyle(Color("AccentColor"))
                                    
                                    TextField("Search...", text: self.$searchText)
                                        .textFieldStyle(OutlinedTextFieldStyle())
                                        .focused(self.$focusedField, equals: .searchBar)
                                    
                                    Button {
                                        self.searchText = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 24))
                                            .padding(.trailing)
                                            .foregroundStyle(Color(UIColor.systemGray2))
                                    }
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .stroke(Color("AccentColor"), lineWidth: 1.0)
                                }
                                .background {
                                    Color("AccentColorMaterial")
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                
                                Button("Cancel") {
                                    self.searchText = ""
                                    withAnimation {
                                        self.showSearchOverlay = false
                                    }
                                }
                            }
                            
                        }.padding()
                    }
                    .zIndex(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                                .padding()
                                .background {
                                    Circle()
                                        .fill(Color("AccentColor"))
                                }
                                .padding()
                        }
                    }
                    .onAppear {
                        self.focusedField = .searchBar
                        
                    }
                    .onDisappear {
                        self.searchText = ""
                    }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                ZTronFiltersFloatingButton(filters: ["Treyarch", "Infinity Ward", "SHG"])
                    .onFilterAdded { filter in
                        withAnimation {
                            self.model.onFilterSelected(filter)
                        }
                    }
                    .onFilterRemoved { filter in
                        withAnimation {
                            self.model.onFilterDisabled(filter)
                        }
                    }
                    .padding(.bottom)
            }
        }
    }
}



public final class HomePageDragDropDelegate: DropDelegate {
    private let dragging: ZTronGameModel
    weak private var model: HomePageModel? = nil
    
    public init(dragging: ZTronGameModel, model: HomePageModel) {
        self.dragging = dragging
        self.model = model
    }
    
    public func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    public func dropEntered(info: DropInfo) {
        self.model?.swapCurrentWith(self.dragging)
    }
}
