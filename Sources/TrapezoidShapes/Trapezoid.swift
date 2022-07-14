
import SwiftUI

public struct Trapezoid: Shape {
    let flexibleEdgeRatio: Double
    let flexibleEdge: FlexibleEdge
    let flexibleEdgeOffset: Double
    private let insetAmount: CGFloat
    
    public init() {
        self.flexibleEdgeRatio = 0.65
        self.flexibleEdge = .top
        self.flexibleEdgeOffset = 0
        self.insetAmount = 0.0
    }
    
    public init(edgeRatio: Double, flexibleEdge: FlexibleEdge = .top, lineOffset: Double = 0) {
        self.flexibleEdgeRatio = edgeRatio
        self.flexibleEdge = flexibleEdge
        self.flexibleEdgeOffset = lineOffset
        self.insetAmount = 0.0
    }
    
    init(edgeRatio: Double, flexibleEdge: FlexibleEdge = .top, lineOffset: Double = 0, inset: CGFloat = 0.0) {
        self.flexibleEdgeRatio = edgeRatio
        self.flexibleEdge = flexibleEdge
        self.flexibleEdgeOffset = lineOffset
        self.insetAmount = 0.0
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedTrapezoid(in: rect,
                              flexibleEdgeRatio: self.flexibleEdgeRatio,
                              flexibleEdge: self.flexibleEdge,
                              topLineOffset: self.flexibleEdgeOffset,
                              cornerRadius: 0,
                              insetAmount: self.insetAmount)
    }
}

@available(macOS 10.15, *)
extension Trapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> Trapezoid {
        Trapezoid(edgeRatio: self.flexibleEdgeRatio,
                  lineOffset: self.flexibleEdgeOffset,
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
                
                Trapezoid(edgeRatio: 0.35, flexibleEdge: .left)
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
