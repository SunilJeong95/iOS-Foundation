//
//  ViewController.swift
//  ImagePicker
//
//  Created by User on 2021/08/05.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(systemName: "person")
        imgView.layer.masksToBounds = true
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.lightGray.cgColor
    
        return imgView
    }()
    
    let label:UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
    
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedImageView))
        
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc private func didTappedImageView(){
        presentPhotoAction()
    }
    
    override func viewDidLayoutSubviews() {
        let size = view.frame.size.width/3
        
        imageView.frame = CGRect(x: (view.frame.size.width-size)/2,
                                 y: 100,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        label.frame = CGRect(x: 0,
                             y: imageView.frame.size.height+imageView.frame.origin.y + 10,
                             width: view.frame.size.width,
                             height: 21)
        
    }
    
    private func presentPhotoAction(){
        let alert = UIAlertController(title: "Profile Photo", message: "Please select a photo for your profile", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            self?.present(vc, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            self?.present(vc, animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageView.image = img
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

