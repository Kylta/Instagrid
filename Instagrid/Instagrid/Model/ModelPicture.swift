//
//  ModelPicture.swift
//  Instagrid
//
//  Created by Christophe Bugnon on 19/02/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import Foundation
import UIKit

struct ModelPicture {
    
    var backgroundColor = [UIColor]()
    var currentBackground = 0
    
    mutating func nextBackgroundPictureView(_ pictureView: PictureView) {
        if currentBackground < backgroundColor.count - 1 {
            currentBackground += 1
            pictureView.backgroundColor = backgroundColor[currentBackground]
        }
    }
    
    mutating func previousBackgroundPictureView(_ pictureView: PictureView) {
        if currentBackground < backgroundColor.count + 1 {
            if currentBackground == 0 {
                currentBackground = 0
            } else {
                currentBackground -= 1
            }
            pictureView.backgroundColor = backgroundColor[currentBackground]
        }
    }
    
    func createImageWithPictureView(pictureView: PictureView) -> UIImage? {
        // Creates a bitmap-based graphics context and makes it the current context.
        UIGraphicsBeginImageContext(pictureView.frame.size)
        // Renders the layer and its sublayers into the specified context.
        pictureView.layer.render(in: UIGraphicsGetCurrentContext()!)
        // Returns an image based on the contents of the current bitmap-based graphics context.
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage(named: "Rectangle 1")}
        
        return image
    }
    
}
