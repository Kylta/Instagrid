//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Bugnon on 06/02/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var settingCollagePicture: UIStackView!
    @IBOutlet weak var pictureView: PictureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            setImage(leftTopPictureIsHidden: true, leftBottomPictureIsHidden: false)
        case 1:
            setImage(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: true)
        case 2:
            setImage(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: false)
        default:
            break
        }
    }
    
    private func setImage(leftTopPictureIsHidden: Bool, leftBottomPictureIsHidden: Bool ) {
        pictureView.stackTopView.viewWithTag(1)?.isHidden = leftTopPictureIsHidden
        pictureView.stackBottomView.viewWithTag(1)?.isHidden = leftBottomPictureIsHidden
    }
    
}

