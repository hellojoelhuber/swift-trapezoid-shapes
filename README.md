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
flexibleEdge:   Determines which base is "flexible." 
                Options are .top (default), .right, .bottom, .left
                The flexible edge is the edge which will grow or shrink based on the edgeRatio; and be offset by the edgeOffset.
edgeOffset:     Determines how acute the trapezoid is. 
                Defaults to 0 for isosceles trapezoid.
```

RoundedTrapezoids can be initialized in the following ways:

```swift
// Defaults cornerOffset to 10, edgeRatio to 0.65, flexibleEdge to .top, edgeOffset to 0. 
RoundedTrapezoid()

// Provide the cornerOffset. Defaults edgeRatio to 0.65, flexibleEdge to .top, edgeOffset to 0.
RoundedTrapezoid(cornerOffset: Double)

// Provide the cornerOffset and edgeRatio. Defaults flexibleEdge to .top, edgeOffset is set to 0.
RoundedTrapezoid(cornerOffset: Double, edgeRatio: Double)
 
// Provide cornerOffset and any of the other 3 properties in any combination. The defaults are as above. You can provide settings for all or some.
RoundedTrapezoid(cornerOffset: Double, edgeRatio: Double, flexibleEdge: FlexibleEdge, edgeOffset: Double)
```

The RoundedTrapezoid cannot be obtuse, unless the cornerOffset = 0.

## Trapezoid

Trapezoid is like the RoundedTrapezoid, except that the cornerOffset is always set to 0 and can be obtuse in shape. 
