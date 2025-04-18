import SwiftUI
import ExyteGrid
import Refresher

enum FocusField: Hashable {
  case searchBar
}

public struct ZTronHomeBackup: View {
    @FocusState private var focusedField: FocusField?

    @Environment(\.verticalSizeClass) private var vSizeClass
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    @Binding private var viewportWidth: CGFloat?
    @Binding private var bottomSafeAreaInset: CGFloat?
    
    @State private var showSearchOverlay: Bool = false
    @State private var searchText: String = ""

    private let tallImageAR: CGFloat
    private let isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    private var vTracks: Int {
        return UIDevice.current.userInterfaceIdiom == .pad ? self.hSizeClass == .regular ? 3 : 2 : 2
    }
    
    private var hTracks: Int {
        return UIDevice.current.userInterfaceIdiom == .pad ? 4 : 3
    }

    
    public init(viewportWidth: Binding<CGFloat?>, bottomSafeAreaInset: Binding<CGFloat?>) {
        self._viewportWidth = viewportWidth
        self._bottomSafeAreaInset = bottomSafeAreaInset
        
        let image = UIImage(named: "bo2.game.logo")!
        self.tallImageAR = image.size.width / image.size.height
    }
    
    
    private var spacing: CGFloat {
        return self.vSizeClass == .regular ? 20 : 20
    }
    
    private var cellWidth: CGFloat? {
        guard let viewportWidth = viewportWidth else { return nil }
        let tracksCount = self.vSizeClass == .regular ? vTracks : hTracks
        var cellWidth = viewportWidth / CGFloat(tracksCount)
        cellWidth -= CGFloat(tracksCount - 1) * self.spacing

        return max(0, cellWidth)
    }
    
    private var gridHeight: CGFloat? {
        guard let cellWidth = self.cellWidth else { return nil }
        let tracksCount = self.vSizeClass == .regular ? vTracks : hTracks
        
        let estimatedImageHeight = cellWidth / tallImageAR
        
        let gridHeight = floor(13.0 / CGFloat(tracksCount)) * (estimatedImageHeight + self.spacing)
        
        return gridHeight
    }
    
    public var body: some View {
        GeometryReader { geo in
            let isPortrait = geo.size.width < geo.size.height
            
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
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    // MARK: - VERTICAL FLOW
                    let targetNumberOfRowsPerPage: Double = self.vSizeClass == .regular ? 3 : 2
                    let estimatedHTracks: CGFloat = floor(13.0 / Double(self.vTracks) / geo.size.width)
                    let totalNumberOfRows: Double = ceil(13.0 / Double(self.vTracks))
                    let totalNumberOfColumns: Double = ceil(13.0 / totalNumberOfRows)
                    let estimatedVCellWidth: CGFloat = (geo.size.width - self.spacing * (totalNumberOfColumns + 1)) / totalNumberOfColumns
                
                    let proposedCellHeight = (geo.size.height - (targetNumberOfRowsPerPage - 1) * self.spacing) / targetNumberOfRowsPerPage
                    let estimatedCellHeight = /*(estimatedVCellWidth / proposedCellHeight) < self.tallImageAR ? estimatedVCellWidth / self.tallImageAR : */ proposedCellHeight
                    let estimatedGridHeight = estimatedCellHeight * totalNumberOfRows + self.spacing * (totalNumberOfRows)
                    
                    // MARK: - HORIZONTAL FLOW
                    let estimatedCellWidth: CGFloat = (geo.size.width - self.spacing * Double(self.hTracks + 1)) / Double(self.hTracks)
                    let estimatedHCellHeight: CGFloat = estimatedCellWidth / self.tallImageAR
                    let totalNumberOfHRows: CGFloat = ceil(13.0 / Double(self.hTracks))
                    let estimatedHGridHeight: CGFloat = estimatedCellWidth / self.tallImageAR * totalNumberOfHRows + self.spacing * (totalNumberOfHRows)
                    
                    Grid(
                        tracks: (!self.isIpad && self.vSizeClass == .regular) || isPortrait ?
                        [GridTrack].init(repeating: .fr(1.0/CGFloat(self.vTracks)), count: self.vTracks)
                            :
                        [GridTrack].init(repeating: .fr(1.0/CGFloat(self.hTracks)), count: self.hTracks),
                        spacing: [self.spacing, self.spacing]
                    ) {
                        
                        ForEach(["bo6", "mw3", "vanguard", "bocw", "bo4", "wwii", "iw", "bo3", "aw", "ghosts", "bo2", "bo", "waw"], id: \.self) { game in
                            GeometryReader { cellGeo in
                                ZStack {
                                    Image("\(game).game.logo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    // MARK: - THE CELL SIZE
                                        .frame(
                                            width: (!self.isIpad && self.vSizeClass == .regular) ||
                                                (self.isIpad && (!isPortrait || isPortrait && self.hSizeClass == .compact)) ? nil : estimatedCellWidth,
                                            height: (!self.isIpad && self.vSizeClass == .regular) ||
                                                (self.isIpad && (!isPortrait || isPortrait && self.hSizeClass == .compact)) ? estimatedCellHeight : nil,
                                            alignment: .center
                                        )
                                        .overlay(
                                            LinearGradient(
                                                colors: [.clear, .black],
                                                startPoint: .top,
                                                endPoint: .bottom)
                                        )
                                        .overlay(alignment: .bottom) {
                                            Image("\(game).text")
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
                                                if game == "waw" || game == "ghosts" || game == "mw3" {
                                                    BackdropBlurView(radius: 5)
                                                        .saturation(0.1)
                                                    Image("zombietron.redacted")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(
                                                            maxWidth:
                                                                (!self.isIpad && self.vSizeClass == .compact) ||
                                                            (self.isIpad && (!isPortrait || isPortrait && self.hSizeClass == .compact))  ? estimatedCellWidth * 0.8 : nil,
                                                            maxHeight:
                                                                (!self.isIpad && self.vSizeClass == .compact) ||
                                                            (self.isIpad && (!isPortrait || isPortrait && self.hSizeClass == .compact)) ? nil : estimatedCellHeight * self.tallImageAR * 0.8
                                                        )
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .gridContentMode(.fill)
                    .gridFlow(.rows)
                    .frame(height:
                            (!self.isIpad && self.vSizeClass == .compact) || (self.isIpad && !isPortrait) ? estimatedHGridHeight : estimatedGridHeight
                    )
                    .frame(maxWidth: .infinity)
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
        }
    }
}
