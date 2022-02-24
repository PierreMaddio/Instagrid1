//
//  ViewController.swift
//  Instagrid
//
//  Created by Pierre on 12/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var arrowToSwipe: UIImageView!
    @IBOutlet weak var textToSwipe: UILabel!
    
    @IBOutlet weak var mainGridView: UIView!
  
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    // 3 buttons to choose the main grid's layout
    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
            self.textToSwipe.text = "Swipe left to share"
        }else{
            self.textToSwipe.text = "Swipe up to share"
        }
    }
    
    // Changing the layout
    
    @IBAction func layout1ButtonTouched(_ sender: Any) {
    }
    
    @IBAction func layout2ButtonTouched(_ sender: Any) {
    }
    
    @IBAction func layout3ButtonTouched(_ sender: Any) {
    }
    
    
    
}

