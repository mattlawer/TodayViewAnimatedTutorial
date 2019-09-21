import UIKit
import CoreGraphics

public class TodaySettingsLayer: CALayer {

    override public init() {
        super.init()

        for i in 0..<3 {
            let cell1 = WidgetCellLayer()
            cell1.bounds = CGRect(x: 0, y: 0, width: 84, height: 18)
            cell1.anchorPoint = CGPoint(x: 0, y: 0)
            cell1.position = CGPoint(x: 3, y: 45+CGFloat(i)*14)
            cell1.isEnabled = true
            cell1.contentsScale = UIScreen.main.scale
            self.addSublayer(cell1)
        }

        for i in 0..<4 {
            let cell1 = WidgetCellLayer()
            cell1.bounds = CGRect(x: 0, y: 0, width: 84, height: 18)
            cell1.anchorPoint = CGPoint(x: 0, y: 0)
            cell1.position = CGPoint(x: 3, y: 119+CGFloat(i)*14)
            cell1.isEnabled = false
            cell1.isOmnistat = true
            cell1.contentsScale = UIScreen.main.scale
            self.addSublayer(cell1)
        }
    }

    override public var bounds: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override public func draw(in context: CGContext) {
        if let bg = self.backgroundColor {
            context.setFillColor(bg)
            context.fill(self.bounds)
        }

        context.setFillColor(UIColor.gray.cgColor)
        context.fill(CGRect(x: 15, y: 10, width: 60, height: 7))

        context.setFillColor(UIColor.lightGray.cgColor)
        context.fill([
            CGRect(x: 10, y: 21, width: 70, height: 3),
            CGRect(x: 6, y: 26, width: 78, height: 3),
            CGRect(x: 17, y: 31, width: 56, height: 3)
        ])
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
