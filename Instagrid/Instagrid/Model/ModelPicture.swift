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
    
    func createImageWithPictureView(pictureView: PictureView) -> UIImage? {
        // Creates a bitmap-based graphics context and makes it the current context.
        UIGraphicsBeginImageContext(pictureView.frame.size)
        // Renders the layer and its sublayers into the specified context.
        pictureView.layer.render(in: UIGraphicsGetCurrentContext()!)
        // Returns an image based on the contents of the current bitmap-based graphics context.
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        return image
    }
    
}
