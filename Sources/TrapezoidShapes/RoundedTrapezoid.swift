import SwiftUI

public struct RoundedTrapezoid: Shape {
    let cornerRadius: Double
    let flexibleEdgeRatio: Double
    let flexibleEdge: FlexibleEdge
    let flexibleEdgeOffset: Double
    private let insetAmount: CGFloat
    
    
    public init() {
        self.cornerRadius = 10
        self.flexibleEdgeRatio = 0.65
        self.flexibleEdge = .top
        self.flexibleEdgeOffset = 0
        self.insetAmount = 0.0
    }
    
    public init(cornerRadius: Double, edgeRatio: Double = 0.65, flexibleEdge: FlexibleEdge = .top, edgeOffset: Double = 0) {
        self.cornerRadius = cornerRadius
        self.flexibleEdgeRatio = edgeRatio
        self.flexibleEdge = flexibleEdge
        self.flexibleEdgeOffset = edgeOffset
        self.insetAmount = 0.0
    }
    
    init(cornerRadius: Double, edgeRatio: Double, flexibleEdge: FlexibleEdge = .top, edgeOffset: Double = 0, inset: CGFloat = 0.0) {
        self.cornerRadius = cornerRadius
        self.flexibleEdgeRatio = edgeRatio
        self.flexibleEdge = flexibleEdge
        self.flexibleEdgeOffset = edgeOffset
        self.insetAmount = inset
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedTrapezoid(in: rect,
                              flexibleEdgeRatio: self.flexibleEdgeRatio,
                              flexibleEdge: self.flexibleEdge,
                              topLineOffset: self.flexibleEdgeOffset,
                              cornerRadius: self.cornerRadius,
                              insetAmount: self.insetAmount)
    }
}

extension RoundedTrapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> RoundedTrapezoid {
        RoundedTrapezoid(cornerRadius: self.cornerRadius, edgeRatio: self.flexibleEdgeRatio, flexibleEdge: self.flexibleEdge, edgeOffset: self.flexibleEdgeOffset, inset: self.insetAmount + amount)
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
                    RoundedTrapezoid(cornerRadius: 8, edgeRatio: 0.35)
                        .foregroundColor(.red.opacity(0.5))
                    RoundedTrapezoid(cornerRadius: 35, edgeRatio: 0.35)
                        .foregroundColor(.red)
                        .padding(5)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
            
                ZStack {
                    RoundedTrapezoid(cornerRadius: 10, edgeRatio: 0.65, edgeOffset: -50)
                        .strokeBorder(lineWidth: 5, antialiased: true)
                    RoundedTrapezoid(cornerRadius: 10, edgeRatio: 0.65, edgeOffset: -50)
                        .foregroundColor(.purple)
                }
                .padding()
                .background(Rectangle().foregroundColor(.white))
                .previewLayout(.fixed(width: frameWidth, height: frameHeight))
                
                ZStack {
                    RoundedTrapezoid(cornerRadius: 10, flexibleEdge: .right)
                        .strokeBorder(Color.blue, lineWidth: 0.5)
                    RoundedTrapezoid(cornerRadius: 10, flexibleEdge: .left)
                        .strokeBorder(Color.red, lineWidth: 0.5)
                        .padding(15)
                    RoundedTrapezoid(cornerRadius: 10, flexibleEdge: .right)
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
