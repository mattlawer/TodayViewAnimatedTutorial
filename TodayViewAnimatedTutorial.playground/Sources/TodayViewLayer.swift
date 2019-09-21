import UIKit
import CoreGraphics

public class TodayViewLayer: CALayer {
    
    override public init() {
        super.init()
    }
    
    override public var bounds: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }

    private func makeWidget(in context: CGContext, rect: CGRect) {
        let widget = UIBezierPath(roundedRect: rect, cornerRadius: 6).cgPath
        context.addPath(widget)
        context.fillPath()
    }

    override public func draw(in context: CGContext) {
        context.setFillColor(UIColor.gray.cgColor)
        makeWidget(in: context, rect: CGRect(x: 6, y: 6, width: 78, height: 12))

        makeWidget(in: context, rect: CGRect(x: 6, y: 22, width: 78, height: 30))
        makeWidget(in: context, rect: CGRect(x: 6, y: 56, width: 78, height: 30))
        makeWidget(in: context, rect: CGRect(x: 6, y: 90, width: 78, height: 30))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
