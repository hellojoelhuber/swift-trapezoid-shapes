
import SwiftUI

public struct Trapezoid: Shape {
    private let topEdgeRatio: Double
    private let topLineOffset: Double
    private let insetAmount: CGFloat
    
    public init() {
        self.topEdgeRatio = 0.65
        self.topLineOffset = 0
        self.insetAmount = 0.0
    }
    
    public init(edgeRatio: Double, lineOffset: Double = 0) {
        self.topEdgeRatio = edgeRatio
        self.topLineOffset = lineOffset
        self.insetAmount = 0.0
    }
    
    init(edgeRatio: Double, lineOffset: Double = 0, inset: CGFloat = 0.0) {
        self.topEdgeRatio = edgeRatio
        self.topLineOffset = lineOffset
        self.insetAmount = 0.0
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedTrapezoid(in: rect,
                              topEdgeRatio: self.topEdgeRatio,
                              topLineOffset: self.topLineOffset,
                              cornerOffset: 0,
                              insetAmount: self.insetAmount)
    }
}

@available(macOS 10.15, *)
extension Trapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> Trapezoid {
        Trapezoid(edgeRatio: self.topEdgeRatio,
                  lineOffset: self.topLineOffset,
                  inset: self.insetAmount + amount)
    }
}


@available(macOS 10.15, *)
struct Trapezoid_Previews: PreviewProvider {
    private struct Preview: View {
        private let frameWidth: CGFloat = 150
        private let frameHeight: CGFloat = 150
        
        var body: some View {
            Group {
                Trapezoid()
                    .strokeBorder(Color.blue, lineWidth: 4)
                    .padding()
                    .background(Rectangle().foregroundColor(.white))
                    .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                Trapezoid(edgeRatio: 0.35)
                    .foregroundColor(.red)
                    .padding()
                    .background(Rectangle().foregroundColor(.white))
                    .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                ZStack {
                    Trapezoid(edgeRatio: 0.65, lineOffset: 100)
                        .strokeBorder(lineWidth: 5, antialiased: true)
                    Trapezoid(edgeRatio: 0.65, lineOffset: 100)
                        .foregroundColor(.purple)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 80))
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth + 100, height: frameHeight))
            }
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
