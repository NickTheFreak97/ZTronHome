import SwiftUI
import ExyteGrid

public struct ZTronGrid<T, V>: View where T: Hashable, V: View {
    
    private let data: [T]
    private var sizingMode: ZTronGridSizingMode = .fitElementsInPage
    private var targetNumberOfElementsPerPage: CGFloat = 3.0
    
    private var pageSize: CGSize = .zero
    
    private var targetVSpacing: CGFloat = 20.0
    private var targetHSpacing: CGFloat = 20.0
    
    private var targetTracks: CGFloat = 2.0
    private var sizingStrategy: any ZTronGridSizingStrategy
    
    private let cellFactory: (T, CGSize) -> V
    
    public init(
        data: [T],
        pageSize: CGSize = .zero,
        @ViewBuilder cellView: @escaping (T, CGSize) -> V
    ) {
        self.data = data
        self.pageSize = pageSize

        self.sizingStrategy = ZTronGridFitHeightStrategy(
            numberOfItems: data.count,
            targetNumberOfRowsPerPage: self.targetNumberOfElementsPerPage,
            tracks: self.targetTracks,
            spacing: .init(x: self.targetHSpacing, y: self.targetVSpacing)
        )
        
        self.cellFactory = cellView
    }
    
    
    public var body: some View {
        Grid(
            tracks: [GridTrack].init(repeating: .fr(1.0/CGFloat(self.targetTracks)), count: Int(self.targetTracks)),
            spacing: [self.targetVSpacing, self.targetHSpacing]
        ) {
            ForEach(self.data, id: \.self) { item in
                self.cellFactory(item, self.sizingStrategy.estimateCellSize(for: self.pageSize))
            }
        }
        .gridContentMode(.fill)
        .gridFlow(.rows)
        .frame(height: self.sizingStrategy.estimateGridHeight(for: self.pageSize))
        .frame(maxWidth: .infinity)
    }
    
    
    public func fitWidth(targetAspectRatio: CGFloat, _ targetHSpacing: CGFloat? = nil) -> Self {
        var copy = self
        
        copy.sizingMode = .fitWidth
        if let targetHSpacing = targetHSpacing {
            copy.targetHSpacing = targetHSpacing
        }
        
        if let currentStrategy = copy.sizingStrategy as? ZTronGridFitWidthStrategy {
            currentStrategy.setSpacing(targetHSpacing, nil)
        } else {
            copy.sizingStrategy = ZTronGridFitWidthStrategy(
                numberOfItems: self.data.count,
                targetNumberOfRowsPerPage: self.targetNumberOfElementsPerPage,
                tracks: self.targetTracks,
                spacing: .init(x: targetHSpacing ?? self.targetHSpacing, y: self.targetVSpacing),
                targetAspectRatio: targetAspectRatio
            )
        }
        
        return copy
    }
    
    public func fitElementsInPage(targetElementsPerPage: CGFloat, targetVSpacing: CGFloat? = nil) -> Self {
        var copy = self
        
        copy.sizingMode = .fitElementsInPage
        copy.targetNumberOfElementsPerPage = CGFloat(targetElementsPerPage)
        copy.sizingMode = .fitWidth
        
        if let targetVSpacing = targetVSpacing {
            copy.targetVSpacing = targetVSpacing
        }
        
        if let currentStrategy = copy.sizingStrategy as? ZTronGridFitWidthStrategy {
            currentStrategy.setSpacing(nil, targetHSpacing)
        } else {
            copy.sizingStrategy = ZTronGridFitHeightStrategy(
                numberOfItems: copy.data.count,
                targetNumberOfRowsPerPage: copy.targetNumberOfElementsPerPage,
                tracks: copy.targetTracks,
                spacing: .init(x: targetHSpacing, y: targetVSpacing ?? self.targetVSpacing)
            )
        }

        return copy
    }
    
    public func withVerticalSpacing(_ targetVSpacing: CGFloat) -> Self {
        var copy = self
        copy.targetVSpacing = targetVSpacing
        self.sizingStrategy.setSpacing(nil, targetVSpacing)
        return copy
    }
    
    public func withHorizontalSpacing(_ targetHSpacing: CGFloat) -> Self {
        var copy = self
        copy.targetHSpacing = targetHSpacing
        self.sizingStrategy.setSpacing(targetHSpacing, nil)
        return copy
    }
    
    public func withSpacing(_ targetSpacing: CGFloat) -> Self {
        var copy = self
        copy.targetVSpacing = targetSpacing
        copy.targetHSpacing = targetSpacing
        self.sizingStrategy.setSpacing(targetSpacing, targetSpacing)
        return copy
    }
    
    public func withTracks(_ tracks: Int) -> Self {
        var copy = self
        copy.targetTracks = CGFloat(tracks)
        self.sizingStrategy.setTracks(tracks)
        return copy
    }

}


public enum ZTronGridSizingMode {
    case fitWidth
    case fitElementsInPage
}

