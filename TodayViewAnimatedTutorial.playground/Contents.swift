//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// Present the view controller in the Live View window
let size = CGSize(width: 96, height: 170)
let widget = WidgetTutoPhoneView(frame: CGRect(origin: .zero, size: size))
widget.backgroundColor = UIColor.systemBackground
PlaygroundPage.current.liveView = widget
