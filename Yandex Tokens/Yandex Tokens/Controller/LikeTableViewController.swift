//
//  LikeTableViewController.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 19.03.2021.
//

import UIKit


class LikeTableViewController: UITableViewController {

    var data = [CompanyProfile](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var imageCache = [String: UIImage?]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"FullTableViewCell", bundle: nil), forCellReuseIdentifier:"FullCell")

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullCell", for: indexPath) as! FullTableViewCell
        
        cell.nameLabel?.text = data[index].name
        cell.symbolLabel?.text = data[index].ticker
        if let cach = imageCache[data[index].logo] {
            cell.logoImage?.image = cach
        }
        

        return cell
    }
    

  
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            self.imageCache[self.data[indexPath.row].logo] = nil
            self.data.remove(at: indexPath.row)
            completion(true)
        }
        actionDel.image = UIImage(systemName: "trash")
        actionDel.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [actionDel])
    }
    

}


