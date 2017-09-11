//
//  WalkthroughContentViewController.swift
//  Food Pin
//
//  Created by Aleksey Rodionov on 12.07.17.
//  Copyright © 2017 HOLLYWOOD Inc. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    
    var index = 0
    var headerText = ""
    var imageName = ""
    var detailText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = headerText
        detailLabel.text = detailText
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardButton.setTitle("NEXT", for: .normal)
        case 2: forwardButton.setTitle("DONE", for: .normal)
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK - IBActions
    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey:"hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }

}
