import Foundation

public protocol ZTronGridSizingStrategy {
    func estimateCellSize(for viewportSize: CGSize) -> CGSize
    func estimateGridHeight(for viewportSize: CGSize) -> CGFloat
    
    func setTargetNumberOfRowsPerPage(_:CGFloat)
    func setTracks(_: Int)
    
    func setSpacing(_: CGFloat?, _: CGFloat?)
}
