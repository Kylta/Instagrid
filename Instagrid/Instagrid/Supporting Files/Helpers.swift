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
    static var lumiere : UIColor { return UIColor(patternImage: UIImage(named: "lumiere")!)}
    static var pexels : UIColor { return UIColor(patternImage: UIImage(named: "pexels-photo")!)}
    static var feuille : UIColor { return UIColor(patternImage: UIImage(named: "feuille")!)}
    static var point : UIColor { return UIColor(patternImage: UIImage(named: "point")!)}
    static var rose : UIColor { return UIColor(patternImage: UIImage(named: "rose")!)}
    static var cailloux : UIColor { return UIColor(patternImage: UIImage(named: "cailloux")!)}
    static var ballon : UIColor { return UIColor(patternImage: UIImage(named: "ballon")!)}
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
