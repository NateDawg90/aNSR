//
//  CustomButton.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
@IBDesignable

class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius;
            layer.masksToBounds = cornerRadius > 0;
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth;
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor;
        }
    }
    

}
