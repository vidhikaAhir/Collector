//
//  AddViewController.swift
//  Collector
//
//  Created by Demo on 14/09/19.
//  Copyright © 2019 vidhika. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            itemImageView.image = choosenImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.titledb = itemTextField.text
            if let image = itemImageView.image{
                if let imageData = image.pngData(){
                    item.imagedb = imageData 
                }
            }
            try? context.save()
            
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}
