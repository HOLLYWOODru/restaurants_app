//
//  ReviewViewController.swift
//  Food Pin
//
//  Created by Aleksey Rodionov on 23.04.17.
//  Copyright © 2017 HOLLYWOOD Inc. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var restaurantImageVuew: UIImageView!
    @IBOutlet var closeButton: UIButton!

    var restaurant: RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Adding Blur to Image view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // Initial position for container view
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        
        containerView.transform = combineTransform
        
        // Settings restaurant image
        restaurantImageVuew.image = UIImage(data: restaurant.image as! Data)
        
        // Initial position for close button
        closeButton.transform = CGAffineTransform.init(translationX: 1000, y: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform.identity
        }, completion: { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.3, animations: {
                self.closeButton.transform = CGAffineTransform.identity
            })
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
