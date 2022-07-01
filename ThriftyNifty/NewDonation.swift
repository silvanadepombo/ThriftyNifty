//
//  NewDonation.swift
//  ThriftyNifty
//
//  Created by Andrea Hurtado on 7/1/22.
//

import UIKit

class NewDonation: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var displayImage: UIImageView!
    
    
    @IBAction func addImage(_ sender: UIButton) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
}


extension NewDonation: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage {
            
            imageView.image = image
            
        }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func   imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
