//
//  TableViewController.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 18.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var imageCache = [String: UIImage?]()
    var data = [CompanyProfile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"FullTableViewCell", bundle: nil), forCellReuseIdentifier:"FullCell")
        Networking.shared.setupData { [weak self] (profile) in
            self!.data = profile
            self!.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullCell", for: indexPath) as! FullTableViewCell
        
        cell.nameLabel?.text = data[index].name
        cell.symbolLabel?.text = data[index].ticker
        if let cach = imageCache[data[index].logo] {
            cell.logoImage?.image = cach
        }else{
            cell.logoImage?.load(urlString: data[index].logo, completion: { [ weak self] (image) in
                self?.imageCache[(self?.data[index].logo)!] = image
            })
            
            
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let navVC = tabBarController?.viewControllers![1] as! UINavigationController
        let vc = navVC.topViewController as! LikeTableViewController
        let data = vc.data
        var i = -1
        for temp in data {
            i = i+1
            if temp.name == self.data[indexPath.row].name{
                let actionAdd = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
                    let data = self?.data[indexPath.row]
                    guard (data != nil) else {return}
                    let url = data!.logo
                    vc.data.remove(at: i)
                    vc.imageCache[url] = nil
                    completion(true)
                }
                actionAdd.image = UIImage(systemName: "trash")
                actionAdd.backgroundColor = .red
                return UISwipeActionsConfiguration(actions: [actionAdd])
            }
        }
        let actionAdd = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            let data = self?.data[indexPath.row]
            guard (data != nil) else {return}
            let url = data!.logo
            let image = self?.imageCache[url]
            vc.data.append(data!)
            vc.imageCache[url] = image
            completion(true)
        }
        actionAdd.backgroundColor = .orange
        actionAdd.image = UIImage(systemName: "plus")
        
        
        
        return UISwipeActionsConfiguration(actions: [actionAdd])
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(identifier: "PriceVC") as! PriceViewController
        vc.data = data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
