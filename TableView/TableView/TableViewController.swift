//
//  TableViewController.swift
//  TableView
//
//  Created by User on 2021/08/03.
//

import UIKit

class TableViewController: UITableViewController{
   
   
    @IBOutlet var TableViewMain: UITableView!
    var newsData:Array<Dictionary<String, Any>>?
    let api:String = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=62fdd2cb5b38434f9acf548d054edc3a" // write your API
    
    func getData(){
        if let url = URL(string: api){
            let task = URLSession.shared.dataTask(with: url) { data, respons, error in
                if let jsonData = data{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Dictionary<String, Any>{
                            let articles = json["articles"] as? Array<Dictionary<String, Any>>
                            self.newsData = articles
                            DispatchQueue.main.async {
                                self.TableViewMain.reloadData()
                            }
                        }
                    }
                    catch{}
                }
           }
           task.resume()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! Cell1
        if let news = newsData{
            if let title = news[indexPath.row]["title"]{
                cell.label.text = title as? String
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData{
            return news.count
        }else{
            return 0
        }
    }

    //method 1 : using Navigation Controller
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let controller = (storyboard?.instantiateViewController(identifier: "DetailViewController")) as? DetailViewController{
//            if let news = newsData{
//                if let desc = news[indexPath.row]["description"]{
//                    controller.label = desc as? String
//                }
//
//                if let imgurl = news[indexPath.row]["urlToImage"]{
//                    controller.imgURL = imgurl as? String
//                }
//            }
//            //showDetailViewController(controller, sender: nil)
//            navigationController?.pushViewController(controller, animated: true)
//        }
//    }
    
    //method 2 : using segue in storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "segue"{
            if let controller = segue.destination as? DetailViewController{
                let index = self.TableViewMain.indexPathForSelectedRow!
                if let news = newsData{
                    if let desc = news[index.row]["description"]{
                        controller.label = desc as? String
                    }

                    if let imgurl = news[index.row]["urlToImage"]{
                        controller.imgURL = imgurl as? String
                    }
                }
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getData()
        
    }
}
