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
    var modelPicture = ModelPicture()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAppli()
        checkOrientationDeviceForSwipeToShareAtStartup(interfaceOrientation: UIApplication.shared.statusBarOrientation)
        
        modelPicture.backgroundColor = [UIColor.pictureViewInitial, UIColor.lumiere, UIColor.pexels, UIColor.feuille, UIColor.point, UIColor.rose, UIColor.cailloux, UIColor.ballon]
        
        
    }
    
    fileprivate func animationReturnIdentity() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pictureView.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func animationPortrait() {
        print("Animate")
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pictureView.transform = .init(translationX: 0, y: self.view.bounds.height/(-3))
        }, completion: nil)
    }
    
    fileprivate func animationLanscape() {
        print("Animate")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pictureView.transform = .init(translationX: self.view.bounds.width/(-3), y: 0)
        }, completion: nil)
    }
    
    // Notifies the container that the size of its view is about to change.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        swipeToShare(deviceOrientation: UIDevice.current.orientation)
    }
    
    // MARK: - Private methods
    
    private func setImagePictureView(leftTopPictureIsHidden: Bool, leftBottomPictureIsHidden: Bool ) {
        pictureView.stackTopView.viewWithTag(1)?.isHidden = leftTopPictureIsHidden
        pictureView.stackBottomView.viewWithTag(3)?.isHidden = leftBottomPictureIsHidden
    }
    
    private func checkImageInButton() -> Bool {
        var isDifferent = false
        
        for button in orderButtonPicture {
            switch button.isSelected {
            case true:
                if button.tag == 0 {
                    if ((pictureView.picture[0].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) ||
                        ((pictureView.picture[2].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) || ((pictureView.picture[3].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) {
                        isDifferent = false
                        alertMissingPicture()
                        return isDifferent
                    }
                }
                if button.tag == 1 {
                    if ((pictureView.picture[0].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) ||
                        ((pictureView.picture[1].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) || ((pictureView.picture[2].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) {
                        isDifferent = false
                        alertMissingPicture()
                        return isDifferent
                    }
                }
                if button.tag == 2 {
                    if ((pictureView.picture[0].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) || ((pictureView.picture[1].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) ||
                        ((pictureView.picture[2].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) || ((pictureView.picture[3].currentImage?.isEqual(UIImage(named: "Combined Shape")))!) {
                        isDifferent = false
                        alertMissingPicture()
                        return isDifferent
                    }
                } else {
                    isDifferent = true
                    return isDifferent
                }
            default:
                break
            }
        }
        return true
    }
    
    private func startAppli() {
        setImagePictureView(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: true)
        orderButtonPicture[1].isSelected = true
        
        disableButtonDifferentOfValue(orderButtonPicture: orderButtonPicture, value: 1, isSelected: false)
    }
    
    private func changeBackgroundColorPortrait() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeChangeBackgroundColor(_:)))
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeChangeBackgroundColor(_:)))
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.right
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeRightGesture)
        view.addGestureRecognizer(swipeLeftGesture)
    }
    
    private func changeBackgroundColorLandscape() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeChangeBackgroundColor(_:)))
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeChangeBackgroundColor(_:)))
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.up
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeUpGesture)
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    private func checkOrientationDeviceForSwipeToShareAtStartup(interfaceOrientation: UIInterfaceOrientation) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureToShare(gesture:)))
        self.view.addGestureRecognizer(swipe)
        switch interfaceOrientation {
        case .portrait, .portraitUpsideDown:
            if interfaceOrientation.isPortrait {
                swipe.direction = UISwipeGestureRecognizerDirection.up
                shareLabel.text = "Swipe up to share"
                changeBackgroundColorPortrait()
            }
        case .landscapeLeft, .landscapeRight:
            if interfaceOrientation.isLandscape {
                swipe.direction = UISwipeGestureRecognizerDirection.left
                shareLabel.text = "Swipe left to share"
                changeBackgroundColorLandscape()
            }
        default:
            break
        }
    }
    
    private func swipeToShare(deviceOrientation: UIDeviceOrientation) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureToShare(gesture:)))
        self.view.addGestureRecognizer(swipe)
        switch deviceOrientation {
        case .portrait, .portraitUpsideDown:
            if deviceOrientation.isPortrait {
                swipe.direction = UISwipeGestureRecognizerDirection.up
                shareLabel.text = "Swipe up to share"
                changeBackgroundColorPortrait()
            }
        case .landscapeLeft, .landscapeRight:
            if deviceOrientation.isLandscape {
                swipe.direction = UISwipeGestureRecognizerDirection.left
                shareLabel.text = "Swipe left to share"
                changeBackgroundColorLandscape()
            }
        default:
            break
        }
    }
    
    private func disableButtonDifferentOfValue(orderButtonPicture: [UIButton], value: Int, isSelected: Bool) {
        for button in orderButtonPicture {
            if button.tag != value {
                button.isSelected = isSelected
            }
        }
    }
    
    private func alertMissingPicture() {
        let alert = UIAlertController(title: "Error", message: "Missing pictures", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.animationReturnIdentity() }))
        present(alert, animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc func handleSwipeChangeBackgroundColor(_ gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.left, UISwipeGestureRecognizerDirection.right:
            if UIApplication.shared.statusBarOrientation.isPortrait {
                if gesture.direction == UISwipeGestureRecognizerDirection.left {
                    print("Swiped left")
                    modelPicture.nextBackgroundPictureView(pictureView)
                }
                if gesture.direction == UISwipeGestureRecognizerDirection.right {
                    print("Swipe right")
                    modelPicture.previousBackgroundPictureView(pictureView)
                }
            }
        case UISwipeGestureRecognizerDirection.up, UISwipeGestureRecognizerDirection.down:
            if UIApplication.shared.statusBarOrientation.isLandscape {
                if gesture.direction == UISwipeGestureRecognizerDirection.down {
                    print("Swiped left")
                    modelPicture.nextBackgroundPictureView(pictureView)
                }
                if gesture.direction == UISwipeGestureRecognizerDirection.up {
                    print("Swipe right")
                    modelPicture.previousBackgroundPictureView(pictureView)
                }
            }
        default:
            break
        }
    }
    
    @objc func respondToSwipeGestureToShare(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            let image = modelPicture.createImageWithPictureView(pictureView: pictureView)!
            // The permitted direction of the swipe for this gesture recognizer.
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                if UIApplication.shared.statusBarOrientation.isPortrait {
                    if checkImageInButton() {
                        // A view controller that you can use to offer various services from your app.
                        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//                        animationPortrait()
                        activityVC.completionWithItemsHandler = completionHandler
                        self.present(activityVC, animated: true, completion: { self.animationPortrait() } )
                    } else {
                        animationPortrait()
                        print("Can't swipe up")
                    }
                }
            case UISwipeGestureRecognizerDirection.left:
                if UIApplication.shared.statusBarOrientation.isLandscape {
                    if checkImageInButton() {
                        // A view controller that you can use to offer various services from your app.
                        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                        activityVC.completionWithItemsHandler = completionHandler
                        self.present(activityVC, animated: true, completion: { self.animationLanscape() })
                    } else {
                        animationLanscape()
                        print("Can't swipe left")
                    }
                }
            default:
                break
            }
        }
    }
    
    func completionHandler(activityType: UIActivityType?, shared: Bool, items: [Any]?, error: Error?) {
        if !(shared) {
            print("Bad not shared")
            animationReturnIdentity()
        }
    }
    
    // MARK: - @IBaction Methods
    
    @IBAction func didTapBottomButtonForChooseOrder(_ sender: UIButton) {
        let firstPicture = pictureView.picture[1]
        let thirthPicture = pictureView.picture[3]
        switch sender.tag {
        case 0:
            // left button
            setImagePictureView(leftTopPictureIsHidden: true, leftBottomPictureIsHidden: false)
            sender.isSelected = true
            
            thirthPicture.setImage(firstPicture.currentImage, for: .normal)
            disableButtonDifferentOfValue(orderButtonPicture: orderButtonPicture, value: 0, isSelected: false)
        case 1:
            // middle button
            setImagePictureView(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: true)
            sender.isSelected = true
            firstPicture.setImage(thirthPicture.currentImage, for: .normal)
            disableButtonDifferentOfValue(orderButtonPicture: orderButtonPicture, value: 1, isSelected: false)
        case 2:
            // right button
            setImagePictureView(leftTopPictureIsHidden: false, leftBottomPictureIsHidden: false)
            sender.isSelected = true
            thirthPicture.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
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
            imagePickerController.allowsEditing = true
            self.imagePickedController = sender.tag
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.imagePickedController = sender.tag
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present((actionSheet), animated: true, completion: nil)
        
    }
        
    // MARK: - UIImagePickerControllerDelegate Methods
    
    // Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            pictureView.picture[imagePickedController].setImage(editImage, for: .normal)
            pictureView.picture[imagePickedController].imageView?.contentMode = .scaleAspectFill
            pictureView.picture[imagePickedController].clipsToBounds = true
            
        } else if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pictureView.picture[imagePickedController].setImage(pickedImage, for: .normal)
            pictureView.picture[imagePickedController].imageView?.contentMode = .scaleAspectFill
            pictureView.picture[imagePickedController].clipsToBounds = true
        }
        
        // Dismisses the view controller that was presented modally by the view controller.
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

