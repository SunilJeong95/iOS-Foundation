//
//  ViewController.swift
//  SearchBar
//
//  Created by User on 2021/08/18.
//

import UIKit

class ViewController: UIViewController {
    private let label:UILabel = {
        let label = UILabel()
        label.text = "No Name"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTappedSearchBar))
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: view.frame.size.height/2, width: view.frame.size.width, height: 50)
    }
    
    @objc private func didTappedSearchBar(){
        let vc = SearchViewController()
        vc.completion = { result in
            self.label.text = result
            self.label.textColor = .black
        }
        let controller = UINavigationController(rootViewController: vc)
        present(controller, animated: true, completion: nil)
        
    }
    

}

