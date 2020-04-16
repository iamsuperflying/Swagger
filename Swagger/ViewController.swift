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
       
        requestAPI()

    }
    
    func requestAPI() {
        AF.request(url, method: .post, parameters: [
            "group": groups[groupControl.selectedSegmentIndex]
        ]).responseJSON { (response) in
            
            if let JSON = response.value {
                
                if let metaResponse = MetaResponse.deserialize(from: JSON as? NSDictionary) {

                    metaResponse.pathsMapping = Dictionary(grouping: metaResponse.paths) { $0.tag }
                    self.metaResponse = metaResponse
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        let tag = self.tags[indexPath.section]
        
        cell?.textLabel?.text = tag.tag_description
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tag = self.tags[section]
        return tag.name
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nav = UINavigationController(rootViewController: APIViewController())
//        self .present(nav, animated: true, completion: nil)
        
        let tag = tags[indexPath.section]
        if let api = metaResponse?.pathsMapping[tag.name] {
            let apiController = APIViewController()
            apiController.api = api.first
            self.navigationController?.pushViewController(apiController, animated: true)
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
