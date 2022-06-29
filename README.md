# Trapezoid Shapes

This package adds RoundedTrapezoid and Trapezoid shapes to SwiftUI.

## RoundedTrapezoid

RoundedTrapezoids have the following properties:

```swift
edgeRatio:      Determines the width of the top compared to the bottom of the trapezoid. 
                Cannot be less than 0. 
                < 1 results in top edge shorter than bottom edge. 
                > 1 results in top edge longer than bottom edge. 
cornerOffset:   Determines the roundness of the corners. 
lineOffset:     Determines how acute the trapezoid is. 
                Defaults to 0 for isosceles trapezoid.
```

RoundedTrapezoids can be initialized in the following ways:

```swift
// Default. Sets edgeRatio to 0.65, cornerOffset to 10, lineOffset to 0. 
RoundedTrapezoid()

// Provide the cornerOffset and edgeRatio. lineOffset is set to 0.
RoundedTrapezoid(cornerOffset: Double, edgeRatio: Double)
 
// Provide all 3 properties.
RoundedTrapezoid(cornerOffset: Double, edgeRatio: Double, lineOffset: Double)
```

The RoundedTrapezoid cannot be obtuse, unless the cornerOffset = 0.

## Trapezoid

Trapezoid is like the RoundedTrapezoid, except that the cornerOffset is always set to 0 and can be obtuse in shape. 
