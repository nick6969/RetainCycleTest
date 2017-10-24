//
//  AppDelegate.swift
//  retainTest
//
//  Created by 林智浩 on 2017/10/24.
//  Copyright © 2017年 林智浩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: MainVC())

        return true
    }

}

public struct OptionalEdge {
    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?
    public init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

extension UIView {
    // swiftlint:disable line_length
    @discardableResult func mLay( _ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, _ attribute1: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute1, multiplier: multiplier, constant: constant)
        layout.isActive = true
        return layout
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier:1, constant:0)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ constant: CGFloat) -> NSLayoutConstraint {
        return mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem:Any?, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem:Any?, constant: CGFloat) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem:Any?, _ attribute1: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant:constant)
    }
    
    @discardableResult func mLay(pin: UIEdgeInsets, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        return [  mLay(.top, .equal, view ?? superview!, constant: pin.top    ),
                  mLay(.left, .equal, view ?? superview!, constant: pin.left ),
                  mLay(.bottom, .equal, view ?? superview!, constant: -pin.bottom ),
                  mLay(.right, .equal, view ?? superview!, constant: -pin.right  )]
    }
    
    @discardableResult func mLayEqualSuper() -> [NSLayoutConstraint] {
        return mLay(pin: .zero)
    }
    
    @discardableResult func mLay(pin: OptionalEdge, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        var arr: [NSLayoutConstraint] = []
        if let top    = pin.top {  arr.append( mLay(.top, .equal, view ?? superview!, constant:  top    ) ) }
        if let left   = pin.left {  arr.append( mLay(.left, .equal, view ?? superview!, constant:  left   ) ) }
        if let bottom = pin.bottom {  arr.append( mLay(.bottom, .equal, view ?? superview!, constant: -bottom ) ) }
        if let right  = pin.right {  arr.append( mLay(.right, .equal, view ?? superview!, constant: -right  ) ) }
        return arr
    }
    
    @discardableResult func mLayCenterXY(to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        return [ mLay(.centerY, .equal, view ?? superview! ),
                 mLay(.centerX, .equal, view ?? superview! )]
    }
    
    @discardableResult func mLay(size: CGSize) -> [NSLayoutConstraint] {
        return [ mLay( .height, size.height), mLay( .width, size.width)]
    }
    // swiftlint:disable line_length
}

extension NSLayoutConstraint {
    
    @discardableResult func priority(_ pri: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = pri
        return self
    }
    
}

