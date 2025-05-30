import Foundation

public final class ZTronGridFitHeightStrategy: ZTronGridSizingStrategy {
    private var numberOfItems: CGFloat
    private var targetNumberOfRowsPerPage: CGFloat
    private var tracks: CGFloat
    private var spacing: CGPoint
    
    private var totalNumberOfRows: CGFloat {
        return ceil(self.numberOfItems / self.tracks)
    }

    public init(
        numberOfItems: Int,
        targetNumberOfRowsPerPage: CGFloat,
        tracks: CGFloat,
        spacing: CGPoint
    ) {
        self.numberOfItems = CGFloat(numberOfItems)
        self.targetNumberOfRowsPerPage = targetNumberOfRowsPerPage
        self.tracks = tracks
        self.spacing = spacing
    }
    
    // FIXME: DOESN'T GUARANTEE ASPECT RATIO
    public func estimateCellSize(for viewportSize: CGSize) -> CGSize {
        let proposedCellHeight = (viewportSize.height - (targetNumberOfRowsPerPage - 1) * self.spacing.y) / targetNumberOfRowsPerPage
        let totalNumberOfColumns: Double = ceil(self.numberOfItems / self.totalNumberOfRows)
        let estimatedCellWidth: CGFloat = (viewportSize.width - self.spacing.x * (totalNumberOfColumns + 1)) / totalNumberOfColumns

        return CGSize(
            width: estimatedCellWidth,
            height: proposedCellHeight
        )
    }
    
    public func estimateGridHeight(for viewportSize: CGSize) -> CGFloat {
        return (self.estimateCellSize(for: viewportSize).height + self.spacing.y) * self.totalNumberOfRows
    }
    
    public func setTargetNumberOfRowsPerPage(_ target: CGFloat) {
        self.targetNumberOfRowsPerPage = target
    }
    
    public func setTracks(_ tracks: Int) {
        self.tracks = CGFloat(tracks)
    }
    
    public func setSpacing(_ vSpacing: CGFloat? = nil, _ hSpacing: CGFloat? = nil) {
        if let vSpacing = vSpacing {
            self.spacing = .init(x: self.spacing.x, y: vSpacing)
        }
        
        if let hSpacing = hSpacing {
            self.spacing = .init(x: hSpacing, y: self.spacing.y)
        }
    }
    
}
