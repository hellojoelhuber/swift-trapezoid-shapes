
import SwiftUI

extension Path {
    static func roundedTrapezoid(in rect: CGRect, topEdgeRatio: Double, ratioVertical: Bool, topLineOffset: Double, cornerOffset: Double, insetAmount: CGFloat) -> Path {
        // edgeRatio cannot be less than 0.
        let edgeRatio = (topEdgeRatio < 0 ? 0 : topEdgeRatio)
        
        // edgeInset is the distance from the frame of the shape to the top line in an isosceles trapezoid
        let edgeInset = (ratioVertical ? rect.maxX : rect.maxY) * ((1-edgeRatio) / 2)
        
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
                         (ratioVertical ? rect.maxX : rect.maxY) * edgeRatio / 2,
                         rect.maxY / 2
        ) + insetAmount / 2
        
        // bottom left corner
        let cornerP1 = CGPoint(x: rect.minX,
                               y: rect.maxY)
        // upper left corner
        let cornerP2 = CGPoint(x: rect.minX + (ratioVertical ? lineOffset + edgeInset : 0),
                               y: rect.minY)
        // upper right corner
        let cornerP3 = CGPoint(x: rect.maxX + (ratioVertical ? lineOffset - edgeInset : 0),
                               y: rect.minY + (ratioVertical ? 0 : lineOffset + edgeInset))
        // bottom right corner
        let cornerP4 = CGPoint(x: rect.maxX,
                               y: rect.maxY + (ratioVertical ? 0 : lineOffset - edgeInset))
        
        let fourCorners = [cornerP1, cornerP2, cornerP3, cornerP4]
        
        var path = Path()
        // initial position is midpoint of bottom edge.
        path.move(to: CGPoint(x: (ratioVertical ? rect.maxX / 2 : rect.minX),
                              y: (ratioVertical ? rect.maxY : rect.maxY / 2)))
        
        // this increments the array by 1 for the horizontal ratio, so we start at midpoint of P1,P2 instead of midpoint P4,P1
        let horizontalOffset = ratioVertical ? 0 : 1
        
        for index in 0..<4 {
            path.addArc(tangent1End: fourCorners[(index + horizontalOffset) % 4], // mod4 protects us against index out of range.
                        tangent2End: fourCorners[(index + horizontalOffset + 1) % 4],
                        radius: offset)
        }
        
        // close the gap in the path, if it exists
        path.closeSubpath()
        return path
    }
}
