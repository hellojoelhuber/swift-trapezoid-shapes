
import SwiftUI

extension Path {
    static func roundedTrapezoid(in rect: CGRect, topEdgeRatio: Double, topLineOffset: Double, cornerOffset: Double, insetAmount: CGFloat) -> Path {
        // edgeRatio cannot be less than 0.
        let edgeRatio = (topEdgeRatio < 0 ? 0 : topEdgeRatio)
        
        // topInset is the distance from the frame of the shape to the top line in an isosceles trapezoid
        let topInset = rect.maxX * ((1-edgeRatio) / 2)
        
        // lineOffset is the distance, left or right, that the top line is shifted
        // If using cornerOffset, the trapezoid cannot be obtuse.
        let lineOffset =
            // positive or negative
            (topLineOffset.sign == .minus ? -1 : 1)
            // multiplied by ternary, condition "if using cornerOffset"
            * (cornerOffset != 0
            // if using cornerOffset, return minimum value of absolute value of missing Top, requested line offset.
                ? min(abs(topInset), abs(topLineOffset))
            // if not using cornerOffset, return the requested line offset.
                : abs(topLineOffset)
              )
        
        // offset (circle radius) is the minimum value of requested offset or one of several midpoints of the shape.
        let offset = min(cornerOffset,
                         rect.maxX / 2,
                         rect.maxX * edgeRatio / 2,
                         rect.maxY / 2
        ) + insetAmount / 2
        
        // bottom left corner
        let cornerP1 = CGPoint(x: rect.minX,
                               y: rect.maxY)
        // upper left corner
        let cornerP2 = CGPoint(x: rect.minX + topInset + lineOffset,
                               y: rect.minY)
        // upper right corner
        let cornerP3 = CGPoint(x: rect.maxX - topInset + lineOffset,
                               y: rect.minY)
        // bottom right corner
        let cornerP4 = CGPoint(x: rect.maxX,
                               y: rect.maxY)
        
        var path = Path()
        // initial position is midpoint of bottom edge.
        path.move(to: CGPoint(x: rect.maxX / 2,
                              y: rect.maxY))
        
        // Bottom Edge, lower-left corner
        path.addArc(tangent1End: cornerP1,
                    tangent2End: cornerP2,
                    radius: offset)
        
        // Left Edge, upper-left corner
        path.addArc(tangent1End: cornerP2,
                    tangent2End: cornerP3,
                    radius: offset)
        
        // Top Edge, upper-right corner
        path.addArc(tangent1End: cornerP3,
                    tangent2End: cornerP4,
                    radius: offset)
        
        // Right Edge, lower-right corner
        path.addArc(tangent1End: cornerP4,
                    tangent2End: cornerP1,
                    radius: offset)
        
        // close the gap in the path, if it exists
        path.closeSubpath()
        return path
    }
}
