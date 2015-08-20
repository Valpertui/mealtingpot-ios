//
//  VPVerticalView.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 29/07/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

@IBDesignable
class VPVerticalView: UIView {

    
    var view: UIView?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    @IBInspectable var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    
    @IBInspectable override var backgroundColor: UIColor? {
        get {
            return view?.backgroundColor
        }
        set {
            guard newValue != nil else
            {
                return
            }
            view?.backgroundColor = newValue
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    
    func xibSetup() -> Void
    {
        guard let view = loadViewFromNib() else
        {
            return
        }
        view.frame = bounds
        
        view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "VPVerticalView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
}
