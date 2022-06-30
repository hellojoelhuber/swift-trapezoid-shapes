import SwiftUI

public struct RoundedTrapezoid: Shape {
    let cornerOffset: Double
    let flexibleEdgeRatio: Double
    let flexibleEdge: FlexibleEdge
    let flexibleEdgeOffset: Double
    private let insetAmount: CGFloat
    
    
    public init() {
        self.cornerOffset = 10
        self.flexibleEdgeRatio = 0.65
        self.flexibleEdge = .top
        self.flexibleEdgeOffset = 0
        self.insetAmount = 0.0
    }
    
    public init(cornerOffset: Double, edgeRatio: Double = 0.65, flexibleEdge: FlexibleEdge = .top, edgeOffset: Double = 0) {
        self.cornerOffset = cornerOffset
        self.flexibleEdgeRatio = edgeRatio
        self.flexibleEdge = flexibleEdge
        self.flexibleEdgeOffset = edgeOffset
        self.insetAmount = 0.0
    }
    
    init(cornerOffset: Double, edgeRatio: Double, flexibleEdge: FlexibleEdge = .top, edgeOffset: Double = 0, inset: CGFloat = 0.0) {
        self.cornerOffset = cornerOffset
        self.flexibleEdgeRatio = edgeRatio
        self.flexibleEdge = flexibleEdge
        self.flexibleEdgeOffset = edgeOffset
        self.insetAmount = inset
    }
    
    public func path(in rect: CGRect) -> Path {
        let initialSideId = { () -> Int in
            switch self.flexibleEdge {
            case .top:
                return 0
            case .right:
                return 1
            case .bottom:
                return 2
            case .left:
                return 3
            }
        }
        return Path.roundedTrapezoid(in: rect,
                              flexibleEdgeRatio: self.flexibleEdgeRatio,
                                     initialSide: initialSideId(),
                              topLineOffset: self.flexibleEdgeOffset,
                              cornerOffset: self.cornerOffset,
                              insetAmount: self.insetAmount)
    }
    
    public enum FlexibleEdge {
        case top
        case right
        case bottom
        case left
    }
}

extension RoundedTrapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> RoundedTrapezoid {
        RoundedTrapezoid(cornerOffset: self.cornerOffset, edgeRatio: self.flexibleEdgeRatio, flexibleEdge: self.flexibleEdge, edgeOffset: self.flexibleEdgeOffset, inset: self.insetAmount + amount)
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
                    RoundedTrapezoid(cornerOffset: 10, edgeRatio: 0.65, edgeOffset: -50)
                        .strokeBorder(lineWidth: 5, antialiased: true)
                    RoundedTrapezoid(cornerOffset: 10, edgeRatio: 0.65, edgeOffset: -50)
                        .foregroundColor(.purple)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                ZStack {
                    RoundedTrapezoid(cornerOffset: 10, flexibleEdge: .right)
                        .strokeBorder(Color.blue, lineWidth: 0.5)
                    RoundedTrapezoid(cornerOffset: 10, flexibleEdge: .left)
                        .strokeBorder(Color.red, lineWidth: 0.5)
                        .padding(15)
                    RoundedTrapezoid(cornerOffset: 10, flexibleEdge: .right)
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
