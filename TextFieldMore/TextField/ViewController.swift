//
//  ViewController.swift
//  TextField
//
//  Created by User on 2021/08/05.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let imageView:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private let emailTextField:UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.returnKeyType = .continue
        field.placeholder = "Email Address..."
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clipsToBounds = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let passwdTextField:UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.returnKeyType = .done
        field.placeholder = "Password..."
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.clipsToBounds = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.clipsToBounds = true
        
        return scroll
    }()
    
    private let loginButton:UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.backgroundColor = .link
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedHideKeyboard))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(gesture)
        scrollView.isUserInteractionEnabled = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwdTextField)
        
        loginButton.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
        
        emailTextField.delegate = self
        passwdTextField.delegate = self
    }
    
    @objc private func didTappedLoginButton(){
        guard let email = emailTextField.text, let passwd = passwdTextField.text,
              !email.isEmpty, !passwd.isEmpty, passwd.count>=6 else{
            alertLoginError()
            return
        }
    }
    
    private func alertLoginError(){
        let alert = UIAlertController(title: "Error", message: "Please check you information to log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTappedHideKeyboard(){
        emailTextField.resignFirstResponder()
        passwdTextField.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                      y: 50,
                                      width: size,
                                      height: size)
        emailTextField.frame = CGRect(x: 30,
                                      y: imageView.bottom+50,
                                      width: scrollView.width-60,
                                      height: 52)
        passwdTextField.frame = CGRect(x: 30,
                                      y: emailTextField.bottom+10,
                                      width: scrollView.width-60,
                                      height: 52)
        loginButton.frame = CGRect(x: 30,
                                      y: passwdTextField.bottom+10,
                                      width: scrollView.width-60,
                                      height: 52)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwdTextField.becomeFirstResponder()
        }
        else if textField == passwdTextField{
            didTappedLoginButton()
        }
        
        return true
    }
        
}

