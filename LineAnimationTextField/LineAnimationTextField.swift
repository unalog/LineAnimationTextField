//
//  LineAnimationTextField.swift
//  LineAnimationTextField
//
//  Created by una on 2017. 2. 27..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit


@IBDesignable
class LineAnimationTextField: UITextField {
    
    @IBInspectable var nomalLineColor = UIColor.clear
    @IBInspectable var focusLineColor = UIColor.clear{
        didSet
        {
            animationView.backgroundColor = focusLineColor
        }
    }
    var animationView = UIView()
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
    
        super.awakeFromNib();
        
        animationView.frame = CGRect(x: self.frame.size.width/2, y: self.frame.size.height-1, width: 0, height: 1)
        animationView.backgroundColor = focusLineColor
        self.addSubview(animationView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LineAnimationTextField.focus), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(LineAnimationTextField.unfocus), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
        
        
    }

    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        
        if (self.isEditing) {
            animationView.frame = CGRect(x:0, y:self.frame.size.height-1, width:self.frame.size.width,height: 1);
        }
        else{
            animationView.frame = CGRect(x:self.frame.size.width/2, y:self.frame.size.height-1, width:0, height:1);
        }
        
    }
    
    
    func focus(notification : NotificationCenter) {
        
    
        animationView.frame = CGRect(x:self.frame.size.width/2, y:self.frame.size.height-1, width:0,height: 1);
    
       UIView.animate(withDuration: 0.5) { 
         self.animationView.frame = CGRect(x:0, y:self.frame.size.height-1, width:self.frame.size.width,height: 1);
        }
        
        
   
    }
    
    
    func unfocus(notification : NotificationCenter) {
        
        
        animationView.frame = CGRect(x:0, y:self.frame.size.height-1, width:self.frame.size.width,height: 1);
        
        UIView.animate(withDuration: 0.5) { 
            self.animationView.frame = CGRect(x:self.frame.size.width/2, y:self.frame.size.height-1, width:0,height: 1);
        }
       
    }
   
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx?.setStrokeColor(self.nomalLineColor.cgColor)
        ctx?.setLineWidth(2.0)
        
        ctx?.move(to: CGPoint(x:0, y:self.bounds.size.height))
        ctx?.addLine(to: CGPoint(x:self.bounds.size.width, y:self.bounds.size.height ))
        
        ctx?.strokePath();
        
        super.draw(rect);
    }
    
    
  

    
}
