import SwiftUI

public struct RoundedTrapezoid: Shape {
    private let topEdgeRatio: Double
    private let cornerOffset: Double
    private let topLineOffset: Double
    private let insetAmount: CGFloat
    private let ratioDirection: RatioDirection
    
    public init() {
        self.topEdgeRatio = 0.65
        self.cornerOffset = 10
        self.topLineOffset = 0
        self.insetAmount = 0.0
        self.ratioDirection = .vertical
    }
    
    public init(cornerOffset: Double, edgeRatio: Double = 0.65, ratioDirection: RatioDirection = .vertical, lineOffset: Double = 0) {
        self.cornerOffset = cornerOffset
        self.topEdgeRatio = edgeRatio
        self.ratioDirection = ratioDirection
        self.topLineOffset = lineOffset
        self.insetAmount = 0.0
    }
    
    init(cornerOffset: Double, edgeRatio: Double, ratioDirection: RatioDirection = .vertical, lineOffset: Double = 0, inset: CGFloat = 0.0) {
        self.cornerOffset = cornerOffset
        self.topEdgeRatio = edgeRatio
        self.ratioDirection = ratioDirection
        self.topLineOffset = lineOffset
        self.insetAmount = inset
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedTrapezoid(in: rect,
                              topEdgeRatio: self.topEdgeRatio,
                              ratioVertical: (self.ratioDirection == .vertical),
                              topLineOffset: self.topLineOffset,
                              cornerOffset: self.cornerOffset,
                              insetAmount: self.insetAmount)
    }
    
    public enum RatioDirection {
        case horizontal
        case vertical
    }
}

extension RoundedTrapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> RoundedTrapezoid {
        RoundedTrapezoid(cornerOffset: self.cornerOffset, edgeRatio: self.topEdgeRatio, ratioDirection: self.ratioDirection, lineOffset: self.topLineOffset, inset: self.insetAmount + amount)
    }
}

struct RoundedTrapezoid_Previews: PreviewProvider {
    private struct Preview: View {
        private let frameWidth: CGFloat = 150
        private let frameHeight: CGFloat = 150
        
        var body: some View {
            Group {
                ZStack {
                    RoundedTrapezoid()
                        .strokeBorder(Color.blue, lineWidth: 0.5)
                    RoundedTrapezoid()
                        .strokeBorder(Color.red, lineWidth: 0.5)
                        .padding(15)
                    RoundedTrapezoid()
                        .strokeBorder(Color.green, lineWidth: 0.5)
                        .padding(30)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                ZStack {
                    RoundedTrapezoid(cornerOffset: 8, edgeRatio: 0.35)
                        .foregroundColor(.red.opacity(0.5))
                    RoundedTrapezoid(cornerOffset: 35, edgeRatio: 0.35)
                        .foregroundColor(.red)
                        .padding(5)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                ZStack {
                    RoundedTrapezoid(cornerOffset: 10, edgeRatio: 0.65, lineOffset: -50)
                        .strokeBorder(lineWidth: 5, antialiased: true)
                    RoundedTrapezoid(cornerOffset: 10, edgeRatio: 0.65, lineOffset: -50)
                        .foregroundColor(.purple)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                ZStack {
                    RoundedTrapezoid(cornerOffset: 10, ratioDirection: .horizontal)
                        .strokeBorder(Color.blue, lineWidth: 0.5)
                    RoundedTrapezoid(cornerOffset: 10, ratioDirection: .horizontal)
                        .strokeBorder(Color.red, lineWidth: 0.5)
                        .padding(15)
                    RoundedTrapezoid(cornerOffset: 10, ratioDirection: .horizontal)
                        .strokeBorder(Color.green, lineWidth: 0.5)
                        .padding(30)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
            }
        }
    }
    static var previews: some View {
        Preview()
    }
}
