//
//  WalkthroughPageViewController.swift
//  Food Pin
//
//  Created by Aleksey Rodionov on 12.07.17.
//  Copyright © 2017 HOLLYWOOD Inc. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageHeaders = ["Personalize", "Locate", "Discover"]
    var pageImageNames = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageDetails = ["Pin your favorite restaurants and create your own food guide",
                       "Search and locate your favorite restaurants on Maps",
                       "Find restaurants pinned by your friends and other foodies around the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Public methods
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index+1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private methods
    func contentViewController(at index: Int) -> WalkthroughContentViewController?
    {
        if index < 0 || index >= pageHeaders.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalktroughContentViewController") as? WalkthroughContentViewController {
            pageViewController.headerText = pageHeaders[index]
            pageViewController.imageName = pageImageNames[index]
            pageViewController.detailText = pageDetails[index]
            pageViewController.index = index
            
            return pageViewController
        }
        
        return nil
    }
    
    // MARK: - UIPageViewControllerDataSource methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
}
