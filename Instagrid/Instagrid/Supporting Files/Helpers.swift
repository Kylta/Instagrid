//
//  Helpers.swift
//  Instagrid
//
//  Created by Christophe Bugnon on 01/03/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import UIKit

extension UIColor {
    static var pictureViewInitial : UIColor { return UIColor(red: 36/255, green: 85/255, blue: 126/255, alpha: 1) }
    static var lumiere : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "light"))}
    static var pexels : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "umbrella"))}
    static var feuille : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "leaf"))}
    static var point : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "psyche-light"))}
    static var rose : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "rose"))}
    static var cailloux : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "stone"))}
    static var ballon : UIColor { return UIColor(patternImage: #imageLiteral(resourceName: "ball"))}
}

extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}
