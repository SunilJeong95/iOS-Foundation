//
//  SearchViewController.swift
//  SearchBar
//
//  Created by User on 2021/08/18.
//

import UIKit

class SearchViewController: UIViewController {
    private let data:[String] = ["Liam", "Noah", "Oliver", "Lucas", "Smith",
                                 "Jane"]
    private var result = [String]()
    public var completion: ((String)->Void)?
    private let tableView:UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.isHidden = true
        return view
    }()
    private let noSearch: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Result"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Searching..."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(noSearch)
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTappedCancel))
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        noSearch.frame = CGRect(x: 0, y: tableView.frame.size.height/2, width: tableView.frame.size.width, height: 50)
    }
    
    @objc private func didTappedCancel(){
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        
        result.removeAll()
        searchData(query: text)
    }
    
    func searchData(query: String){
        let result:[String] = data.filter { data in
            data.hasPrefix(query)
        }
        
        self.result = result
        if result.isEmpty {
            tableView.isHidden = true
            noSearch.isHidden = false
        } else {
            tableView.isHidden = false
            noSearch.isHidden = true
            tableView.reloadData()
        }
    }
}

extension SearchViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell")  {
            cell.textLabel?.text = result[indexPath.row]
            return cell
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = result[indexPath.row]
        dismiss(animated: true) {
            self.completion?(name)
        }
        
    }
    
    
}
