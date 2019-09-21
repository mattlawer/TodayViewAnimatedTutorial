import UIKit
import CoreGraphics

public class WidgetCellLayer: CALayer {
    
    var isOmnistat: Bool = false
    @objc dynamic var isEnabled: Bool = false

    override public init() {
        super.init()
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)

        guard let widget = layer as? WidgetCellLayer else { return }
        self.isOmnistat = widget.isOmnistat
        self.isEnabled = widget.isEnabled
    }
    
    override public var bounds: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override public func draw(in context: CGContext) {
        context.setFillColor(UIColor.white.cgColor)
        context.addPath(UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath)
        context.fillPath()

        if isEnabled {
            context.setFillColor(UIColor(red: 0.99, green: 0.24, blue: 0.19, alpha: 1.0).cgColor)
            context.fillEllipse(in: CGRect(x: 4, y: 4.5, width: 9, height: 9))

            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: 5, y: 8, width: 7, height: 2))
        } else {
            context.setFillColor(UIColor(red: 0.19, green: 0.78, blue: 0.35, alpha: 1.0).cgColor)
            context.fillEllipse(in: CGRect(x: 4, y: 4.5, width: 9, height: 9))

            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: 5, y: 8, width: 7, height: 2))
            context.fill(CGRect(x: 7.5, y: 5.5, width: 2, height: 7))
        }

        if isOmnistat {
            let backColor = UIColor(red: 0.72, green: 0.85, blue: 1.0, alpha: 1.0)
            let circleColor = UIColor(red: 0.03, green: 0.49, blue: 1.0, alpha: 1.0)

            context.setFillColor(backColor.cgColor)
            context.addPath(UIBezierPath(roundedRect: CGRect(x: 15, y: 4, width: 10, height: 10), cornerRadius: 3).cgPath)
            context.fillPath()

            context.setFillColor(circleColor.cgColor)
            context.fillEllipse(in: CGRect(x: 15.5, y: 4.5, width: 9, height: 9))

            context.setFillColor(UIColor.white.cgColor)
            context.fillEllipse(in: CGRect(x: 17.5, y: 6.5, width: 5, height: 5))
        } else {
            context.setFillColor(UIColor.lightGray.cgColor)
            context.addPath(UIBezierPath(roundedRect: CGRect(x: 15, y: 4, width: 10, height: 10), cornerRadius: 3).cgPath)
            context.fillPath()
        }

        context.setFillColor(UIColor.gray.cgColor)
        context.fill(CGRect(x: 28, y: 7.5, width: 34, height: 3))

        context.setFillColor(UIColor(white: 0.9, alpha: 1.0).cgColor)
        context.fill(CGRect(x: 68.5, y: 4.5, width: 9, height: 9))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override public class func needsDisplay(forKey key: String) -> Bool {
        if key == "isEnabled" || key == "isOmnistat" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
}
