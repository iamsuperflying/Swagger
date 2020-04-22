//
//  ViewController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/15.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var groupControl: UISegmentedControl!
    
    let groups = ["用户APP接口文档","商户APP接口文档"];
    let url = "https://testserver.cheyoudaren.com/v2/api-docs"
    
    let identifier = "MasterAPICell"
    
    var metaResponse: MetaResponse?
    var tags = [Tag]() {
        didSet {
            self.tagsView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tagsView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tagsView.register(UINib(nibName:identifier, bundle: nibBundle), forCellReuseIdentifier:identifier)
        requestAPI()

    }
    
    func requestAPI() {
        AF.request(url, method: .post, parameters: [
            "group": groups[groupControl.selectedSegmentIndex]
        ]).responseJSON { (response) in
            
            if let JSON = response.value {
                 
                if let metaResponse = MetaResponse.deserialize(from: JSON as? Dictionary) {
                    self.metaResponse = metaResponse
                    Redis.standard.definitions = metaResponse.definitions
                    self.tags = metaResponse.tags
                }

            }
        }
    }
    
    @IBAction func groupChanged(_ sender: UISegmentedControl) {
        requestAPI()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.tags.count
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tag = tags[section]
        return metaResponse?.pathsMapping[tag.name]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MasterAPICell
        let tag = self.tags[indexPath.section]
        
        cell.titleLabel.text = metaResponse?.pathsMapping[tag.name]?[indexPath.row].httpMethod?.summary
        cell.detailLabel.text = metaResponse?.pathsMapping[tag.name]?[indexPath.row].name
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tag = self.tags[section]
        return tag.name
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self .present(nav, animated: true, completion: nil)
        
        let tag = tags[indexPath.section]
        if let api = metaResponse?.pathsMapping[tag.name] {
            let apiController = APIViewController()
            apiController.api = api[indexPath.row]
            if let definitions = metaResponse?.definitions {
                apiController.definitions = definitions
            }
            let nav = UINavigationController(rootViewController: apiController)
            splitViewController?.showDetailViewController(nav, sender: nav)
        }
        
    }
    
    /// 搜索文字改变
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText: \(searchText)")
        
        guard searchText.count != 0 else {
            if let tags = self.metaResponse?.tags {
                self.tags = tags
            }
            return
        }
        
        if let tags = self.metaResponse?.tags.filter({ (tag: Tag) -> Bool in
            return (tag.name.contains(searchText.uppercased()))
        }) {
            self.tags = tags
            self.tagsView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

