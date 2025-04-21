import SwiftUI
import ExyteGrid
import Refresher
import SwiftUIIntrospect


struct ContentView: View, KeyboardReadable {
    
    @State private var activeTab: Int = 0
    @State private var bottomBarHeight: CGFloat? = nil
    @State private var safeAreaBottomInset: CGFloat? = nil
    @State private var viewportWidth: CGFloat? = nil
    @State private var tabIndicatorOffset: CGFloat = .zero
    @State private var isKeyboardVisible: Bool = false
    
    @StateObject private var homePageModel: HomePageModel = .init()
    @StateObject private var homePageFilters: ZTronFilterModel = .init(filters: ["Treyarch", "Infinity Ward", "SHG"])
    @StateObject private var toolsFilters: ZTronFilterModel = .init(filters: ["Easter Eggs", "Skull Breaker", "Side Quests", "Music"])
    
    
    private var indicatorHeight: CGFloat? {
        guard let bottomBarHeight = self.bottomBarHeight else { return nil }
        guard let safeAreaBottomInset = self.safeAreaBottomInset else { return nil }
        
        return bottomBarHeight - safeAreaBottomInset
    }
    
    @Environment(\.horizontalSizeClass) private var originalHSizeClass
    
    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(named: "brand.bg")
        
        let transparentAppearance = UINavigationBarAppearance()
        transparentAppearance.configureWithTransparentBackground()
        transparentAppearance.backgroundColor = UIColor(named: "brand.bg")
        
        let blurryAppearance = UINavigationBarAppearance()
        blurryAppearance.configureWithDefaultBackground()
        
        UINavigationBar.appearance().scrollEdgeAppearance = transparentAppearance
        UINavigationBar.appearance().standardAppearance = blurryAppearance
        
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            TabView(selection: self.$activeTab) {
                Group {
                    ZTronHome(model: self.homePageModel, viewportWidth: self.$viewportWidth)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                                .font(.system(.footnote, design: .rounded).weight(self.activeTab == 0 ? .bold : .medium))
                        }
                        .tag(0)
                    
                    ZTronToolsSelection(self.toolsFilters)
                        .tabItem {
                            Label("Team Up", systemImage: "person.2.fill")
                                .font(.system(.footnote, design: .rounded).weight(self.activeTab == 1 ? .bold : .medium))
                        }
                        .tag(1)
                    
                    ZTronMapSelection()
                        .tabItem {
                            Label("Favourites", systemImage: "star.fill")
                                .font(.system(.footnote, design: .rounded).weight(self.activeTab == 2 ? .bold : .medium))
                        }
                        .tag(2)
                    
                    Text("Features")
                        .tabItem {
                            Label("Features", systemImage: "text.bubble.fill")
                                .font(.system(.footnote, design: .rounded).weight(self.activeTab == 3 ? .bold : .medium))
                        }
                        .tag(3)
                }
                .ignoresSafeArea(.keyboard, edges: .all)
                .environment(\.horizontalSizeClass, self.originalHSizeClass)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background {
                    Color("brand.bg")
                        .ignoresSafeArea(.all, edges: .all)
                }                .animation(.bouncy, value: self.activeTab)
                .background {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                let scenes = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
                                let keyWindow = scenes.first(where: { $0.keyWindow != nil })?.keyWindow ?? scenes.first?.keyWindow
                                
                                self.safeAreaBottomInset = keyWindow?.safeAreaInsets.bottom ?? geo.safeAreaInsets.bottom
                                self.viewportWidth = geo.frame(in: .local).width
                            }
                            .onChange(of: geo.safeAreaInsets) { _ in
                                let scenes = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
                                let keyWindow = scenes.first(where: { $0.keyWindow != nil })?.keyWindow ?? scenes.first?.keyWindow
                                
                                self.safeAreaBottomInset = keyWindow?.safeAreaInsets.bottom ?? geo.safeAreaInsets.bottom
                            }
                            .onChange(of: geo.frame(in: .local).width) { _ in
                                self.viewportWidth = geo.frame(in: .local).width
                            }
                    }
                }
            }
            .onChange(of: self.activeTab) { _ in
                withAnimation {
                    if let viewportWidth = self.viewportWidth {
                        self.tabIndicatorOffset = viewportWidth / 4.0 * CGFloat(self.activeTab)
                    }
                }
            }
            .onChange(of: self.viewportWidth) { viewportWidth in
                if let viewportWidth = viewportWidth {
                    self.tabIndicatorOffset = viewportWidth / 4.0 * CGFloat(self.activeTab)
                }
            }
            .environment(\.horizontalSizeClass, .compact)
            .ignoresSafeArea(.keyboard, edges: .all)
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("TopbarLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical, 3)
                        .frame(height: 42)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                    }
                }
            }
            .introspect(.tabView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { tabController in
                Task(priority: .userInitiated) { @MainActor in
                    self.bottomBarHeight =  tabController.tabBar.frame.size.height
                }
            }
            .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                withAnimation {
                    isKeyboardVisible = newIsKeyboardVisible
                }
            }
            
            
            if !self.isKeyboardVisible {
                if let indicatorHeight = self.indicatorHeight {
                    Rectangle()
                        .fill(Color("AccentColor").opacity(0.15))
                        .ignoresSafeArea(.keyboard, edges: .vertical)
                        .frame(maxWidth: viewportWidth == nil ? .infinity : viewportWidth!/4.0)
                        .frame(height: indicatorHeight)
                        .blur(radius: 28)
                        .border(width: 2, edges: [.top], color: .accentColor)
                        .offset(x: viewportWidth == nil ? .zero : self.tabIndicatorOffset, y: 0)
                        .transition(.opacity)
                        .animation(.default, value: self.activeTab)
                        .allowsHitTesting(false)
                        .zIndex(0)
                }
            }
            
            VStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.accentColor.opacity(0.1))
                    .frame(height: 1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

/// A View in which content reflects all behind it
struct BackdropView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect()
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
    
}

/// A transparent View that blurs its background
struct BackdropBlurView: View {
    
    let radius: CGFloat
    
    @ViewBuilder
    var body: some View {
        BackdropView().blur(radius: radius)
    }
    
}
