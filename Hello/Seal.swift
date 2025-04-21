import SwiftUI

struct Seal: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.21207*width, y: 0.12335*height))
        path.addCurve(to: CGPoint(x: 0.49989*width, y: 0.03438*height), control1: CGPoint(x: 0.31753*width, y: 0.14143*height), control2: CGPoint(x: 0.42571*width, y: 0.10799*height))
        path.addCurve(to: CGPoint(x: 0.78772*width, y: 0.12335*height), control1: CGPoint(x: 0.57406*width, y: 0.10799*height), control2: CGPoint(x: 0.68226*width, y: 0.14143*height))
        path.addCurve(to: CGPoint(x: 0.96555*width, y: 0.35618*height), control1: CGPoint(x: 0.80226*width, y: 0.22434*height), control2: CGPoint(x: 0.86913*width, y: 0.31184*height))
        path.addCurve(to: CGPoint(x: 0.96555*width, y: 0.64389*height), control1: CGPoint(x: 0.91497*width, y: 0.44597*height), control2: CGPoint(x: 0.91497*width, y: 0.5541*height))
        path.addCurve(to: CGPoint(x: 0.78772*width, y: 0.87671*height), control1: CGPoint(x: 0.86913*width, y: 0.68823*height), control2: CGPoint(x: 0.80226*width, y: 0.77573*height))
        path.addCurve(to: CGPoint(x: 0.4999*width, y: 0.96568*height), control1: CGPoint(x: 0.68226*width, y: 0.85864*height), control2: CGPoint(x: 0.57406*width, y: 0.89207*height))
        path.addCurve(to: CGPoint(x: 0.21207*width, y: 0.87671*height), control1: CGPoint(x: 0.42573*width, y: 0.89207*height), control2: CGPoint(x: 0.31753*width, y: 0.85864*height))
        path.addCurve(to: CGPoint(x: 0.03424*width, y: 0.64389*height), control1: CGPoint(x: 0.19753*width, y: 0.7757*height), control2: CGPoint(x: 0.13066*width, y: 0.68822*height))
        path.addCurve(to: CGPoint(x: 0.03424*width, y: 0.35618*height), control1: CGPoint(x: 0.08482*width, y: 0.55408*height), control2: CGPoint(x: 0.08483*width, y: 0.44597*height))
        path.addCurve(to: CGPoint(x: 0.21207*width, y: 0.12335*height), control1: CGPoint(x: 0.13066*width, y: 0.31184*height), control2: CGPoint(x: 0.19753*width, y: 0.22434*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.21207*width, y: 0.12335*height))
        path.addCurve(to: CGPoint(x: 0.49989*width, y: 0.03438*height), control1: CGPoint(x: 0.31753*width, y: 0.14143*height), control2: CGPoint(x: 0.42571*width, y: 0.10799*height))
        path.addCurve(to: CGPoint(x: 0.78772*width, y: 0.12335*height), control1: CGPoint(x: 0.57406*width, y: 0.10799*height), control2: CGPoint(x: 0.68226*width, y: 0.14143*height))
        path.addCurve(to: CGPoint(x: 0.96555*width, y: 0.35618*height), control1: CGPoint(x: 0.80226*width, y: 0.22434*height), control2: CGPoint(x: 0.86913*width, y: 0.31184*height))
        path.addCurve(to: CGPoint(x: 0.96555*width, y: 0.64389*height), control1: CGPoint(x: 0.91497*width, y: 0.44597*height), control2: CGPoint(x: 0.91497*width, y: 0.5541*height))
        path.addCurve(to: CGPoint(x: 0.78772*width, y: 0.87671*height), control1: CGPoint(x: 0.86913*width, y: 0.68823*height), control2: CGPoint(x: 0.80226*width, y: 0.77573*height))
        path.addCurve(to: CGPoint(x: 0.4999*width, y: 0.96568*height), control1: CGPoint(x: 0.68226*width, y: 0.85864*height), control2: CGPoint(x: 0.57406*width, y: 0.89207*height))
        path.addCurve(to: CGPoint(x: 0.21207*width, y: 0.87671*height), control1: CGPoint(x: 0.42573*width, y: 0.89207*height), control2: CGPoint(x: 0.31753*width, y: 0.85864*height))
        path.addCurve(to: CGPoint(x: 0.03424*width, y: 0.64389*height), control1: CGPoint(x: 0.19753*width, y: 0.7757*height), control2: CGPoint(x: 0.13066*width, y: 0.68822*height))
        path.addCurve(to: CGPoint(x: 0.03424*width, y: 0.35618*height), control1: CGPoint(x: 0.08482*width, y: 0.55408*height), control2: CGPoint(x: 0.08483*width, y: 0.44597*height))
        path.addCurve(to: CGPoint(x: 0.21207*width, y: 0.12335*height), control1: CGPoint(x: 0.13066*width, y: 0.31184*height), control2: CGPoint(x: 0.19753*width, y: 0.22434*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.21207*width, y: 0.12335*height))
        path.addCurve(to: CGPoint(x: 0.49989*width, y: 0.03438*height), control1: CGPoint(x: 0.31753*width, y: 0.14143*height), control2: CGPoint(x: 0.42571*width, y: 0.10799*height))
        path.addCurve(to: CGPoint(x: 0.78772*width, y: 0.12335*height), control1: CGPoint(x: 0.57406*width, y: 0.10799*height), control2: CGPoint(x: 0.68226*width, y: 0.14143*height))
        path.addCurve(to: CGPoint(x: 0.96555*width, y: 0.35618*height), control1: CGPoint(x: 0.80226*width, y: 0.22434*height), control2: CGPoint(x: 0.86913*width, y: 0.31184*height))
        path.addCurve(to: CGPoint(x: 0.96555*width, y: 0.64389*height), control1: CGPoint(x: 0.91497*width, y: 0.44597*height), control2: CGPoint(x: 0.91497*width, y: 0.5541*height))
        path.addCurve(to: CGPoint(x: 0.78772*width, y: 0.87671*height), control1: CGPoint(x: 0.86913*width, y: 0.68823*height), control2: CGPoint(x: 0.80226*width, y: 0.77573*height))
        path.addCurve(to: CGPoint(x: 0.4999*width, y: 0.96568*height), control1: CGPoint(x: 0.68226*width, y: 0.85864*height), control2: CGPoint(x: 0.57406*width, y: 0.89207*height))
        path.addCurve(to: CGPoint(x: 0.21207*width, y: 0.87671*height), control1: CGPoint(x: 0.42573*width, y: 0.89207*height), control2: CGPoint(x: 0.31753*width, y: 0.85864*height))
        path.addCurve(to: CGPoint(x: 0.03424*width, y: 0.64389*height), control1: CGPoint(x: 0.19753*width, y: 0.7757*height), control2: CGPoint(x: 0.13066*width, y: 0.68822*height))
        path.addCurve(to: CGPoint(x: 0.03424*width, y: 0.35618*height), control1: CGPoint(x: 0.08482*width, y: 0.55408*height), control2: CGPoint(x: 0.08483*width, y: 0.44597*height))
        path.addCurve(to: CGPoint(x: 0.21207*width, y: 0.12335*height), control1: CGPoint(x: 0.13066*width, y: 0.31184*height), control2: CGPoint(x: 0.19753*width, y: 0.22434*height))
        path.closeSubpath()
        return path
    }
}
