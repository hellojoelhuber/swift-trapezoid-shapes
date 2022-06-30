
import SwiftUI

extension Path {
    static func roundedTrapezoid(in rect: CGRect, flexibleEdgeRatio: Double, initialSide: Int, topLineOffset: Double, cornerOffset: Double, insetAmount: CGFloat) -> Path {
        // edgeRatio cannot be less than 0.
        let edgeRatio = (flexibleEdgeRatio < 0 ? 0 : flexibleEdgeRatio)
        
        // edgeInset is the distance from the frame of the shape to the top line in an isosceles trapezoid
        let edgeInset = (initialSide % 2 == 0 ? rect.maxX : rect.maxY) * ((1-edgeRatio) / 2)
        
        // lineOffset is the distance, left or right, that the top line is shifted
        // If using cornerOffset, the trapezoid cannot be obtuse.
        let lineOffset =
            // positive or negative
            (topLineOffset.sign == .minus ? -1 : 1)
            // multiplied by ternary, condition "if using cornerOffset"
            * (cornerOffset != 0
            // if using cornerOffset, return minimum value of absolute value of missing Top, requested line offset.
                ? min(abs(edgeInset), abs(topLineOffset))
            // if not using cornerOffset, return the requested line offset.
                : abs(topLineOffset)
              )
        
        // offset (circle radius) is the minimum value of requested offset or one of several midpoints of the shape.
        let offset = min(cornerOffset,
                         rect.maxX / 2,
                         (initialSide % 2 == 0 ? rect.maxX : rect.maxY) * edgeRatio / 2,
                         rect.maxY / 2
        ) + insetAmount / 2
        
        // bottom left corner
        let cornerP1 = CGPoint(x: rect.minX + (initialSide == 2 ? lineOffset + edgeInset : 0),
                               y: rect.maxY + (initialSide == 3 ? lineOffset - edgeInset : 0))
        // upper left corner
        let cornerP2 = CGPoint(x: rect.minX + (initialSide == 0 ? lineOffset + edgeInset : 0),
                               y: rect.minY + (initialSide == 3 ? lineOffset + edgeInset : 0))
        // upper right corner
        let cornerP3 = CGPoint(x: rect.maxX + (initialSide == 0 ? lineOffset - edgeInset : 0),
                               y: rect.minY + (initialSide == 1 ? lineOffset + edgeInset : 0))
        // bottom right corner
        let cornerP4 = CGPoint(x: rect.maxX + (initialSide == 2 ? lineOffset - edgeInset : 0),
                               y: rect.maxY + (initialSide == 1 ? lineOffset - edgeInset : 0))
        
        let fourCorners = [cornerP1, cornerP2, cornerP3, cornerP4]
        
        var path = Path()
        
        // initial side
        // 0 = top flexible
        // 1 = right flexible
        // 2 = bottom
        // 3 = left
        
        path.move(to: CGPoint(x: (fourCorners[(initialSide + 3) % 4].x + fourCorners[initialSide].x) / 2,
                              y: (fourCorners[(initialSide + 3) % 4].y + fourCorners[initialSide].y) / 2
                             ))
        
        for index in 0..<4 {
            path.addArc(tangent1End: fourCorners[(index + initialSide) % 4], // mod4 protects us against index out of range.
                        tangent2End: fourCorners[(index + initialSide + 1) % 4],
                        radius: offset)
        }
        
        // close the gap in the path, if it exists
        path.closeSubpath()
        return path
    }
}
