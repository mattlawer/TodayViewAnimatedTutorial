//
//  LayerView.swift
//  Exported from Kite Compositor for Mac 1.9.4
//
//  Created on 05/09/2019 10:50.
//

import UIKit

public class WidgetTutoView: UIView, CAAnimationDelegate {

    lazy var homeScreenLayer: HomeScreenLayer = {
        let homeScreenLayer = HomeScreenLayer()
        homeScreenLayer.bounds = CGRect(x: 0, y: 0, width: 90, height: 160)
        homeScreenLayer.anchorPoint = CGPoint(x: 0, y: 0)
        homeScreenLayer.position = CGPoint(x: 0, y: 0)
        homeScreenLayer.backgroundColor = UIColor.black.cgColor
        homeScreenLayer.isOpaque = true
        homeScreenLayer.contentsScale = UIScreen.main.scale
        //homeScreenLayer.rasterizationScale = UIScreen.main.scale
        //homeScreenLayer.shouldRasterize = true
        return homeScreenLayer
    }()

    lazy var todayViewLayer: TodayViewLayer = {
        let todayViewLayer = TodayViewLayer()
        todayViewLayer.bounds = CGRect(x: 0, y: 0, width: 90, height: 160)
        todayViewLayer.anchorPoint = CGPoint(x: 0, y: 0)
        todayViewLayer.position = CGPoint(x: -90, y: 0)
        todayViewLayer.backgroundColor = UIColor.black.cgColor
        todayViewLayer.isOpaque = true
        todayViewLayer.contentsScale = UIScreen.main.scale
        //todayViewLayer.rasterizationScale = UIScreen.main.scale
        //todayViewLayer.shouldRasterize = true
        return todayViewLayer
    }()

    lazy var todaySettingsButtonLayer: CALayer = {
        let todaySettingsButtonLayer = CALayer()
        todaySettingsButtonLayer.bounds = CGRect(x: 0, y: 0, width: 34, height: 12)
        todaySettingsButtonLayer.position = CGPoint(x: 45, y: 130)
        todaySettingsButtonLayer.backgroundColor = UIColor.white.cgColor
        todaySettingsButtonLayer.cornerRadius = 6
        todaySettingsButtonLayer.isOpaque = true
        return todaySettingsButtonLayer
    }()

    lazy var todaySettingsLayer: TodaySettingsLayer = {
        let todaySettingsLayer = TodaySettingsLayer()
        todaySettingsLayer.bounds = CGRect(x: 0, y: 0, width: 90, height: 160)
        todaySettingsLayer.anchorPoint = CGPoint(x: 0, y: 0)
        todaySettingsLayer.position = CGPoint(x: 0, y: 160)
        todaySettingsLayer.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0).cgColor
        todaySettingsLayer.isOpaque = true
        todaySettingsLayer.contentsScale = UIScreen.main.scale
        return todaySettingsLayer
    }()

    lazy var movingCell: WidgetCellLayer = {
        let movingCell = WidgetCellLayer()
        movingCell.name = "WidgetCellLayer"
        movingCell.bounds = CGRect(x: 0, y: 0, width: 84, height: 18)
        movingCell.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        movingCell.position = CGPoint(x: 45, y: 114)
        movingCell.isOmnistat = true
        movingCell.contentsScale = UIScreen.main.scale
        return movingCell
    }()

    // MARK: - Initialization

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 90, height: 160))
        self.setupLayers()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayers()
    }

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.addAnimations()
    }

    // MARK: - Setup Layers

    private func setupLayers() {
        self.layer.addSublayer(self.homeScreenLayer)
        self.layer.addSublayer(self.todayViewLayer)
        self.todayViewLayer.addSublayer(self.todaySettingsButtonLayer)
        self.layer.addSublayer(self.todaySettingsLayer)
        self.todaySettingsLayer.addSublayer(self.movingCell)

        self.backgroundColor = UIColor.black
        self.clipsToBounds = true
    }

    func addAnimations() {
        self.movingCell.removeAllAnimations()
        self.homeScreenLayer.removeAllAnimations()
        self.todayViewLayer.removeAllAnimations()
        self.todaySettingsButtonLayer.removeAllAnimations()
        self.todaySettingsLayer.removeAllAnimations()

        let currentTime = self.layer.convertTime(CACurrentMediaTime(), from: nil)
        let slideLeft1 = self.slideLeftAnimation(from: 0, to: 90)
        slideLeft1.beginTime = currentTime + 1
        self.homeScreenLayer.add(slideLeft1, forKey: "slideLeft")

        let slideLeft2 = self.slideLeftAnimation(from: -90, to: 0)
        slideLeft2.beginTime = currentTime + 1
        self.todayViewLayer.add(slideLeft2, forKey: "slideLeft")

        let bounce = bounceButtonAnimation()
        bounce.beginTime = currentTime + 1.8
        self.todaySettingsButtonLayer.add(bounce, forKey: "bounce")

        let showSettings = showSettingsAnimation()
        showSettings.beginTime = currentTime + 2.7
        showSettings.delegate = self
        self.todaySettingsLayer.add(showSettings, forKey: "show")

        let focusAnim = focus()
        focusAnim.beginTime = currentTime + 3.7
        self.movingCell.add(focusAnim, forKey: "focus")
        let moveUpAnim = moveUp()
        moveUpAnim.beginTime = currentTime + 4
        self.movingCell.add(moveUpAnim, forKey: "moveUp")
        let unfocusAnim = focus(unfocus: true)
        unfocusAnim.beginTime = currentTime + 4.5
        self.movingCell.add(unfocusAnim, forKey: "unfocus")
        let enableAnim = enableCell(true)
        enableAnim.beginTime = currentTime + 4.4
        self.movingCell.add(enableAnim, forKey: "enable")

        let hideSettings = hideSettingsAnimation()
        hideSettings.beginTime = currentTime + 5.5
        hideSettings.delegate = self
        self.todaySettingsLayer.add(hideSettings, forKey: "hide")
    }

    // MARK: - Animations

    private func slideLeftAnimation(from: CGFloat, to: CGFloat) -> CASpringAnimation {
        let positionAnimation = CASpringAnimation()
        positionAnimation.duration = 0.65
        positionAnimation.fillMode = .forwards
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.keyPath = "position.x"
        positionAnimation.toValue = to
        positionAnimation.fromValue = from
        positionAnimation.stiffness = 200
        positionAnimation.damping = 16
        positionAnimation.mass = 0.7
        positionAnimation.initialVelocity = 4
        return positionAnimation
    }

    private func bounceButtonAnimation() -> CASpringAnimation {
        let transformScaleXyAnimation = CASpringAnimation()
        transformScaleXyAnimation.duration = 0.3
        transformScaleXyAnimation.autoreverses = true
        transformScaleXyAnimation.fillMode = .forwards
        transformScaleXyAnimation.isRemovedOnCompletion = true
        transformScaleXyAnimation.keyPath = "transform.scale.xy"
        transformScaleXyAnimation.toValue = 1.2
        transformScaleXyAnimation.fromValue = 1
        transformScaleXyAnimation.stiffness = 200
        transformScaleXyAnimation.damping = 10
        transformScaleXyAnimation.mass = 0.7
        transformScaleXyAnimation.initialVelocity = 4
        return transformScaleXyAnimation
    }

    private func showSettingsAnimation() -> CASpringAnimation {
        let transformTranslationYAnimation = CASpringAnimation()
        transformTranslationYAnimation.duration = 0.6
        transformTranslationYAnimation.fillMode = .forwards
        transformTranslationYAnimation.isRemovedOnCompletion = false
        transformTranslationYAnimation.keyPath = "transform.translation.y"
        transformTranslationYAnimation.toValue = -160
        transformTranslationYAnimation.fromValue = 0
        transformTranslationYAnimation.stiffness = 200
        transformTranslationYAnimation.damping = 38
        transformTranslationYAnimation.mass = 0.7
        transformTranslationYAnimation.initialVelocity = 4
        return transformTranslationYAnimation
    }

    private func focus(unfocus: Bool = false) -> CASpringAnimation {
        let transformScaleXyAnimation = CASpringAnimation()
        transformScaleXyAnimation.duration = 0.727259
        transformScaleXyAnimation.fillMode = .forwards
        transformScaleXyAnimation.isRemovedOnCompletion = false
        transformScaleXyAnimation.keyPath = "transform.scale.xy"
        transformScaleXyAnimation.toValue = unfocus ? 1 : 1.1
        transformScaleXyAnimation.fromValue = unfocus ? 1.1 : 1
        transformScaleXyAnimation.stiffness = 200
        transformScaleXyAnimation.damping = 14
        transformScaleXyAnimation.mass = 0.7
        transformScaleXyAnimation.initialVelocity = 4
        return transformScaleXyAnimation
    }

    private func moveUp() -> CABasicAnimation {
        let transformTranslationYAnimation2 = CABasicAnimation()
        transformTranslationYAnimation2.duration = 0.5
        transformTranslationYAnimation2.fillMode = .forwards
        transformTranslationYAnimation2.isRemovedOnCompletion = false
        transformTranslationYAnimation2.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transformTranslationYAnimation2.keyPath = "transform.translation.y"
        transformTranslationYAnimation2.toValue = -18
        transformTranslationYAnimation2.fromValue = 0
        return transformTranslationYAnimation2
    }

    private func enableCell(_ value: Bool) -> CABasicAnimation {
        let transformTranslationYAnimation2 = CABasicAnimation()
        transformTranslationYAnimation2.duration = 0.1
        transformTranslationYAnimation2.fillMode = .forwards
        transformTranslationYAnimation2.isRemovedOnCompletion = false
        transformTranslationYAnimation2.keyPath = "isEnabled"
        transformTranslationYAnimation2.toValue = value
        transformTranslationYAnimation2.fromValue = !value
        return transformTranslationYAnimation2
    }

    private func hideSettingsAnimation() -> CASpringAnimation {
        let transformTranslationYAnimation1 = CASpringAnimation()
        transformTranslationYAnimation1.duration = 0.5
        transformTranslationYAnimation1.fillMode = .forwards
        transformTranslationYAnimation1.isRemovedOnCompletion = false
        transformTranslationYAnimation1.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transformTranslationYAnimation1.keyPath = "transform.translation.y"
        transformTranslationYAnimation1.toValue = 0
        transformTranslationYAnimation1.stiffness = 200
        transformTranslationYAnimation1.damping = 20
        transformTranslationYAnimation1.mass = 0.7
        transformTranslationYAnimation1.initialVelocity = 4
        return transformTranslationYAnimation1
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if anim == self.todaySettingsLayer.animation(forKey: "hide") {
                // reset animations
                self.addAnimations()
            } else if anim == self.todaySettingsLayer.animation(forKey: "show") {
                // reset homescreen
                self.homeScreenLayer.removeAllAnimations()
                self.homeScreenLayer.setNeedsDisplay() // change colors
                self.todayViewLayer.removeAllAnimations()
            }
        }
    }
    
}
