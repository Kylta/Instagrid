//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Bugnon on 06/02/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var settingCollagePicture: UIStackView!
    @IBOutlet weak var pictureView: PictureView!
    
    var imagePickedController = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeUpToShare()
    }
    
    // MARK: - Private methods
    
    private func setImage(leftTopPictureIsHidden: Bool, leftBottomPictureIsHidden: Bool ) {
        pictureView.stackTopView.viewWithTag(1)?.isHidden = leftTopPictureIsHidden
        pictureView.stackBottomView.viewWithTag(0)?.isHidden = leftBottomPictureIsHidden
    }
    
    private func swipeUpToShare() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    // MARK: - @objc Methods
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            UIGraphicsBeginImageContext(pictureView.frame.size)
            
            pictureView.layer.render(in: UIGraphicsGetCurrentContext()!)
            
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                
                self.present(activityVC, animated: true, completion: nil)
                print("Swipe up")
            default:
                break
            }
        }
    }
    
    // MARK: - @IBaction Methods

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
    
    @IBAction func choosePicture(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.imagePickedController = sender.tag
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.imagePickedController = sender.tag
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present((actionSheet), animated: true, completion: nil)
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pictureView.picture[imagePickedController].setImage(pickedImage, for: .normal)
            pictureView.picture[imagePickedController].contentMode = .scaleAspectFit
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

