//
//  Extensions.swift
//  Innagram
//
//  Created by YANA on 08/11/2021.
//

import UIKit

extension UIView{
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var heigth: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension String {
    func safeDatabaseKey() -> String{
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        
    }
}
