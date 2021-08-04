//
//  ViewController.swift
//  TableView
//
//  Created by User on 2021/08/03.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Label: UILabel!
    
    var imgURL:String?
    var label:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imgurl = imgURL{
            if let img = URL(string: imgurl){
                if let data = try? Data(contentsOf: img){
                    DispatchQueue.main.async {
                        self.ImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        if let l = label{
            Label.text = l
        }
        
    }


}

