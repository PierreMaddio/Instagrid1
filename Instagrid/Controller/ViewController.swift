//
//  ViewController.swift
//  Instagrid
//
//  Created by Pierre on 12/02/2022.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var arrowToSwipe: UIImageView!
    @IBOutlet weak var textToSwipe: UILabel!
    @IBOutlet weak var mainGridView: UIView!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    // 3 buttons to choose the main grid's layout
    @IBOutlet weak var firstGridButton: UIButton!
    @IBOutlet weak var secondGridButton: UIButton!
    @IBOutlet weak var thirdGridButton: UIButton!
    
    @IBOutlet weak var swipeStackView: UIStackView!
    
    
    // MARK: - Properties
    
    var topLeftButtonSelected = false
    var topRightButtonSelected = false
    var bottomLeftButtonSelected = false
    var bottomRightButtonSelected = false
    
    // Lazy var allows instantiation of property only when we start to use it in the code
    // to access the lazy variable and change the direction of the swipe (Landscape)
    lazy var swipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        return swipe
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectGridButton(.secondGrid)
        manageGridView(.secondGrid)
        checkAuthorizationOfPhotos()
        manageSwipeConfig()
        swipeStackView.addGestureRecognizer(swipe)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        manageSwipeConfig()
    }
    
    // MARK: - Methods
    
    // Changing the layout
    @IBAction func firstGridAction(_ sender: Any) {
        selectGridButton(.firstGrid)
        manageGridView(.firstGrid)
    }
    
    @IBAction func secondGridAction(_ sender: Any) {
        selectGridButton(.secondGrid)
        manageGridView(.secondGrid)
    }
    
    @IBAction func thirdGridAction(_ sender: Any) {
        selectGridButton(.thirdGrid)
        manageGridView(.thirdGrid)
    }
    
    // manage the display of the image "Selected"
    private func selectGridButton(_ button: GridView) {
        switch button {
        case .firstGrid:
            firstGridButton.setImage(UIImage(named: "Selected"), for: .normal)
            secondGridButton.setImage(nil, for: .normal)
            thirdGridButton.setImage(nil, for: .normal)
            
        case .secondGrid:
            firstGridButton.setImage(nil, for: .normal)
            secondGridButton.setImage(UIImage(named: "Selected"), for: .normal)
            thirdGridButton.setImage(nil, for: .normal)
            
        case .thirdGrid:
            firstGridButton.setImage(nil, for: .normal)
            secondGridButton.setImage(nil, for: .normal)
            thirdGridButton.setImage(UIImage(named: "Selected"), for: .normal)
        }
    }
    
    // manage the display of the main grid
    private func manageGridView(_ view: GridView) {
        switch view {
        case .firstGrid:
            topLeftButton.isHidden = false
            topRightButton.isHidden = true
            bottomLeftButton.isHidden = false
            bottomRightButton.isHidden = false
            
        case .secondGrid:
            topLeftButton.isHidden = false
            topRightButton.isHidden = false
            bottomLeftButton.isHidden = false
            bottomRightButton.isHidden = true
            
        case .thirdGrid:
            topLeftButton.isHidden = false
            topRightButton.isHidden = false
            bottomLeftButton.isHidden = false
            bottomRightButton.isHidden = false
        }
    }
    
    @IBAction func topLeftButtonAction(_ sender: Any) {
        presentGaleriesOfPhotos()
        topLeftButtonSelected = true
        topRightButtonSelected = false
        bottomLeftButtonSelected = false
        bottomRightButtonSelected = false
    }
    
    @IBAction func topRightButtonAction(_ sender: Any) {
        presentGaleriesOfPhotos()
        topLeftButtonSelected = false
        topRightButtonSelected = true
        bottomLeftButtonSelected = false
        bottomRightButtonSelected = false
    }
    
    @IBAction func bottomLeftButtonAction(_ sender: Any) {
        presentGaleriesOfPhotos()
        topLeftButtonSelected = false
        topRightButtonSelected = false
        bottomLeftButtonSelected = true
        bottomRightButtonSelected = false
    }
        
    @IBAction func bottomRightButtonAction(_ sender: Any) {
        presentGaleriesOfPhotos()
        topLeftButtonSelected = false
        topRightButtonSelected = false
        bottomLeftButtonSelected = false
        bottomRightButtonSelected = true
    }
    
    // Photo Library Permission
    private func checkAuthorizationOfPhotos() {
        PHPhotoLibrary.requestAuthorization { _ in }
    }
    
    // Check the status of the authorization
    // DispatchQueue.main.async -> to switch from a thread X to the main thread, use to run a code of UIKit components
    private func presentGaleriesOfPhotos() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            DispatchQueue.main.async {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.delegate = self
                    imagePickerController.sourceType = .photoLibrary
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "We were unable to load your album groups. Sorry!",
                    message: "You can enable access in Privacy Settings",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    // method of the UIImagePickerControllerDelegate protocol
    // detect select image from galeries
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if topLeftButtonSelected {
            topLeftButton.setImage(image, for: .normal)
        }
        if topRightButtonSelected {
            topRightButton.setImage(image, for: .normal)
        }
        if bottomLeftButtonSelected {
            bottomLeftButton.setImage(image, for: .normal)
        }
        if bottomRightButtonSelected {
            bottomRightButton.setImage(image, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // swipe
    // depending on the orientation configuration of the swipe and the text content
    func manageSwipeConfig() {
        if UIDevice.current.orientation.isLandscape {
            self.textToSwipe.text = "Swipe left to share"
            self.swipe.direction = .left
        } else {
            self.textToSwipe.text = "Swipe up to share"
            self.swipe.direction = .up
        }
    }
    
    // action of swipe
    @objc func swipeAction() {
        let translation : CGAffineTransform
        if UIDevice.current.orientation.isLandscape {
            translation = CGAffineTransform(translationX: -mainGridView.frame.maxX, y: 0)
        } else {
            translation = CGAffineTransform(translationX: 0, y: -mainGridView.frame.maxY)
        }
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.mainGridView.transform = translation
        }, completion: { _ in
            self.sharedContent()
        })
    }
    
    // check all the buttons of the main grid if they contain images
    // ac is the view that appears to share the images
    func sharedContent() {
        var items: [UIImage] = []
        if let topLeftButtonImg = topLeftButton.imageView?.image {
            items.append(topLeftButtonImg)
        }
        if let topRightButtonImg = topRightButton.imageView?.image {
            items.append(topRightButtonImg)
        }
        if let bottomLeftButtonImg = bottomLeftButton.imageView?.image {
            items.append(bottomLeftButtonImg)
        }
        if let bottomRightButtonImg = bottomRightButton.imageView?.image {
            items.append(bottomRightButtonImg)
        }
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        // detection of the closing of the Shared screen
        ac.completionWithItemsHandler = { (_, completed:Bool, _ ,  _) in
            // Do something
            let translation : CGAffineTransform
            if UIDevice.current.orientation.isLandscape {
                translation = CGAffineTransform(translationX: -self.mainGridView.frame.maxX, y: 0)
            } else {
                translation = CGAffineTransform(translationX: 0, y: -self.mainGridView.frame.maxY)
            }
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.mainGridView.transform = translation
            }, completion: nil)
        }
        present(ac, animated: true)
    }
}



