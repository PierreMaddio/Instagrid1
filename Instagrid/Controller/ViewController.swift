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
    @IBOutlet weak var firstGridButton: UIButton!
    @IBOutlet weak var secondGridButton: UIButton!
    @IBOutlet weak var thirdGridButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didSelectGridButton(.secondGrid)
        manageGridView(.secondGrid)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
            self.textToSwipe.text = "Swipe left to share"
        }else{
            self.textToSwipe.text = "Swipe up to share"
        }
    }
    
    // Changing the layout
    @IBAction func firstGridAction(_ sender: Any) {
        didSelectGridButton(.firstGrid)
        manageGridView(.firstGrid)
    }
    
    @IBAction func secondGridAction(_ sender: Any) {
        didSelectGridButton(.secondGrid)
        manageGridView(.secondGrid)
    }
    
    @IBAction func thirdGridAction(_ sender: Any) {
        didSelectGridButton(.thirdGrid)
        manageGridView(.thirdGrid)
    }
    
    /// manage the display of the image "Selected"
    private func didSelectGridButton(_ button: GridView) {
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
    
    /// manage the display of the main grid
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
        topLeftButton.setImage(UIImage(named: "Selected"), for: .normal)
    }
    
    
    
    
}

