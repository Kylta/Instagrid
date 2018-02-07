//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Bugnon on 06/02/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var orderButtonPicture: [UIButton]!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var pictureView: PictureView!
    
    var imagePickedController = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Notifies the container that the size of its view is about to change.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation)
        determineMyDeviceOrientation()
    }
    
    // MARK: - Private methods
    
    private func determineMyDeviceOrientation()
    {
        if UIDevice.current.orientation.isLandscape {
            print("Device is in landscape mode")
            shareLabel.text = "Swipe left to share"
            swipeleftToShare()
        } else {
            print("Device is in portrait mode")
            shareLabel.text = "Swipe up to share"
            swipeUpToShare()
        }
    }
    
    private func setImage(leftTopPictureIsHidden: Bool, leftBottomPictureIsHidden: Bool ) {
        pictureView.stackTopView.viewWithTag(1)?.isHidden = leftTopPictureIsHidden
        pictureView.stackBottomView.viewWithTag(0)?.isHidden = leftBottomPictureIsHidden
    }
    
    private func swipeUpToShare() {
        // A concrete subclass of UIGestureRecognizer that looks for swiping gestures in one or more directions.
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    private func swipeleftToShare() {
        // A concrete subclass of UIGestureRecognizer that looks for swiping gestures in one or more directions.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    private func disableButtonDifferentOfValue(orderButtonPicture: [UIButton], value: Int, isSelected: Bool) {
        for button in orderButtonPicture {
            if button.tag != value {
                button.isSelected = isSelected
            }
        }
    }
    
    // MARK: - @objc Methods
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            // Creates a bitmap-based graphics context and makes it the current context.
            UIGraphicsBeginImageContext(pictureView.frame.size)
            // Renders the layer and its sublayers into the specified context.
            pictureView.layer.render(in: UIGraphicsGetCurrentContext()!)
            // Returns an image based on the contents of the current bitmap-based graphics context.
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
            // The permitted direction of the swipe for this gesture recognizer.
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                // A view controller that you can use to offer various services from your app.
                let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                
                self.present(activityVC, animated: true, completion: nil)
                print("Swipe up")
            case UISwipeGestureRecognizerDirection.left:
                // A view controller that you can use to offer various services from your app.
                let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                
                self.present(activityVC, animated: true, completion: nil)
                print("Swipe left")
            default:
                break
            }
        }
    }
    
    // MARK: - @IBaction Methods

    @IBAction func didTapBottomButtonForChooseOrder(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // left button
            setImage(leftTopPictureIsHidden: true, leftBottomPictureIsHidden: false)
            sender.isSelected = true
            
            disableButtonDifferentOfValue(orderButtonPicture: orderButtonPicture, value: 0, isSelected: false)
        case 1:
            // middle button
            setImage(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: true)
            sender.isSelected = true
            
            disableButtonDifferentOfValue(orderButtonPicture: orderButtonPicture, value: 1, isSelected: false)
        case 2:
            // right button
            setImage(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: false)
            sender.isSelected = true
            
            disableButtonDifferentOfValue(orderButtonPicture: orderButtonPicture, value: 2, isSelected: false)
        default:
            break
        }
    }
    
    @IBAction func choosePicture(_ sender: UIButton) {
        // An object that manages customizable, system-supplied user interfaces for taking pictures and movies on supported devices, and for choosing saved images and movies for use in your app.
        let imagePickerController = UIImagePickerController()
        // The image picker’s delegate object.
        imagePickerController.delegate = self
        // An object that displays an alert message to the user.
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        // Attaches an action object to the alert or action sheet.
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            // The type of picker interface to be displayed by the controller.
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
    
    // Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pictureView.picture[imagePickedController].setImage(pickedImage, for: .normal)
            pictureView.picture[imagePickedController].contentMode = .scaleAspectFit
        }
        
        // Dismisses the view controller that was presented modally by the view controller.
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

