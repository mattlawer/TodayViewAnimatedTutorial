import UIKit
import CoreGraphics

public class HomeScreenLayer: CALayer {

    override public init() {
        super.init()
    }

    override public init(layer: Any) {
        super.init(layer: layer)
    }
    
    override public var bounds: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// Generating bright colors
    /// The sum of the red, green and blue components (from 0 to 255) should be between 450 and 650
    private func getRandomIconColor() -> UIColor {
        let maxV = Int(450+(arc4random()%200))
        var minV = max(maxV-510, 0)
        let r = minV+Int(arc4random()%UInt32(255-minV))
        minV = max(maxV-r-255, 0)
        let g = minV == 255 ? minV : minV+Int(arc4random()%UInt32(255-minV))
        let b = maxV-r-g
        let array = [CGFloat(r)/255, CGFloat(g)/255, CGFloat(b)/255].shuffled()
        return UIColor(red: array[0], green: array[1], blue: array[2], alpha: 1.0)
    }

    private func makeAppIcon(in context: CGContext, position: CGPoint, color: UIColor) {
        let iconPath = UIBezierPath(roundedRect: CGRect(x: position.x, y: position.y, width: 25, height: 25), cornerRadius: 6).cgPath
        context.addPath(iconPath)
        context.setFillColor(color.cgColor)
        context.fillPath()
    }

    override public func draw(in context: CGContext) {

        for i in 0..<3 {
            for j in 0..<4 {
                makeAppIcon(in: context, position: CGPoint(x: 4+CGFloat(i)*28.5, y: 4+CGFloat(j)*28.5), color: getRandomIconColor())
            }
        }

        for i in 0..<3 {
            makeAppIcon(in: context, position: CGPoint(x: 4+CGFloat(i)*28.5, y: 131), color: getRandomIconColor())
        }

        context.setFillColor(UIColor.gray.cgColor)
        context.fillEllipse(in: CGRect(x: 35.5, y: 120, width: 5, height: 5))
        context.fillEllipse(in: CGRect(x: 49.5, y: 120, width: 5, height: 5))

        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: CGRect(x: 42.5, y: 120, width: 5, height: 5))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
