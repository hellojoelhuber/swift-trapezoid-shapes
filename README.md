# Trapezoid Shapes

This package adds RoundedTrapezoid and Trapezoid shapes to SwiftUI.

## RoundedTrapezoid

RoundedTrapezoids have the following properties:

```swift
cornerOffset:   Determines the roundness of the corners.
edgeRatio:      Determines the width of the top or right edge compared to the bottom or left edge (respectively) of the trapezoid. 
                Cannot be less than 0. 
                < 1 results in top or right edge shorter than bottom or left edge. 
                > 1 results in top or right edge longer than bottom or left edge.
ratioDirection: Determines if the edgeRatio is between the top and bottom edges or the left and right edges.
                Options are .vertical (default) or .horizontal.
lineOffset:     Determines how acute the trapezoid is. 
                Defaults to 0 for isosceles trapezoid.
```

RoundedTrapezoids can be initialized in the following ways:

```swift
// Defaults cornerOffset to 10, edgeRatio to 0.65, ratioDirection to .vertical, lineOffset to 0. 
RoundedTrapezoid()

// Provide the cornerOffset. Defaults edgeRatio to 0.65, ratioDirection to .vertical, lineOffset to 0.
RoundedTrapezoid(cornerOffset: Double)

// Provide the cornerOffset and edgeRatio. Defaults ratioDirection to .vertical, lineOffset is set to 0.
RoundedTrapezoid(cornerOffset: Double, edgeRatio: Double)
 
// Provide cornerOffset and any of the other 3 properties in any combination. The defaults are as above. You can provide settings for all or some.
RoundedTrapezoid(cornerOffset: Double, edgeRatio: Double, ratioDirection: RatioDirection, lineOffset: Double)
```

The RoundedTrapezoid cannot be obtuse, unless the cornerOffset = 0.

## Trapezoid

Trapezoid is like the RoundedTrapezoid, except that the cornerOffset is always set to 0 and can be obtuse in shape. 
