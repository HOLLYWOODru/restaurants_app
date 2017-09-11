//
//  AddRestaurantController.swift
//  Food Pin
//
//  Created by Aleksey Rodionov on 12.06.17.
//  Copyright © 2017 HOLLYWOOD Inc. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var restaurantNameTextField: UITextField!
    @IBOutlet var restaurantTypeTextField: UITextField!
    @IBOutlet var restaurantLocationTextField: UITextField!
    @IBOutlet var restaurantPhoneTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var isVisited = true
    var restaurant: RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
    // IBAction methods
    @IBAction func toogleBeenHereButton(sender: UIButton) {
        if(sender == yesButton) {
            isVisited = true
            
            yesButton.backgroundColor = UIColor(red: 216/255.0, green: 74/255.0, blue: 32/255.0, alpha: 1)
            noButton.backgroundColor = UIColor.lightGray
            
        } else {
            isVisited = false
            
            noButton.backgroundColor = UIColor(red: 216/255.0, green: 74/255.0, blue: 32/255.0, alpha: 1)
            yesButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func save(sender: UIButton) {
        if restaurantNameTextField.text!.isEmpty || restaurantTypeTextField.text!.isEmpty || restaurantLocationTextField.text!.isEmpty || restaurantPhoneTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ooops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required!", preferredStyle: .alert)
            present(alertController, animated: true, completion: nil)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction) -> Void in
                print("Bad fields")
            }))
        } else {
            print("* * * New restaurant info * * *")
            print("Name: \(String(describing: restaurantNameTextField.text))")
            print("Type: \(String(describing: restaurantTypeTextField.text))")
            print("Location: \(String(describing: restaurantLocationTextField.text))")
            print("Phone number: \(String(describing: restaurantLocationTextField.text))")
            print("Have you been here: "  + (isVisited ? "true": "false"))
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = restaurantNameTextField.text
                restaurant.type = restaurantTypeTextField.text
                restaurant.location = restaurantLocationTextField.text
                restaurant.phone = restaurantPhoneTextField.text
                restaurant.isVisited = isVisited
                
                if let restaurantImage = photoImageView.image {
                    if let imageData = UIImagePNGRepresentation(restaurantImage) {
                        restaurant.image = NSData(data: imageData)
                    }
                }
                
                print("Saving data to context...")
                
                appDelegate.saveContext()
            }
            
            performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        }
    }
}
