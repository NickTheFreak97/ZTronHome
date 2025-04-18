import Foundation

public final class ZTronGridFitWidthStrategy: ZTronGridSizingStrategy {
    private var numberOfItems: CGFloat
    private var targetNumberOfRowsPerPage: CGFloat
    private var tracks: CGFloat
    private var spacing: CGPoint
    private var targetAspectRatio: CGFloat
    
    private var totalNumberOfRows: CGFloat {
        return ceil(self.numberOfItems / self.tracks)
    }

    public init(
        numberOfItems: Int,
        targetNumberOfRowsPerPage: CGFloat,
        tracks: CGFloat,
        spacing: CGPoint,
        targetAspectRatio: CGFloat
    ) {
        self.numberOfItems = CGFloat(numberOfItems)
        self.targetNumberOfRowsPerPage = targetNumberOfRowsPerPage
        self.tracks = tracks
        self.spacing = spacing
        self.targetAspectRatio = targetAspectRatio
    }
    
    public func estimateCellSize(for viewportSize: CGSize) -> CGSize {
        let estimatedCellWidth: CGFloat = (viewportSize.width - self.spacing.x * Double(self.tracks + 1)) / Double(self.tracks)
        let estimatedHCellHeight: CGFloat = estimatedCellWidth / self.targetAspectRatio
         
        return CGSize(
            width: estimatedCellWidth,
            height: estimatedHCellHeight
        )
    }
    
    public func estimateGridHeight(for viewportSize: CGSize) -> CGFloat {
        return self.totalNumberOfRows * (self.estimateCellSize(for: viewportSize).width / self.targetAspectRatio + self.spacing.x)
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
    
    public func setTargetAspectRatio(_  target: CGFloat) {
        self.targetAspectRatio = target
    }
}
