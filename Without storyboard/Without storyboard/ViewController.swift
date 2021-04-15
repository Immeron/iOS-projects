//
//  ViewController.swift
//  Without storyboard
//
//  Created by Илья Виноградов on 14.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
        tableView.rowHeight = view.frame.width * 9/16
        title = "Without stor"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableViewConstraints()
    }
    
    
    func tableViewConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

    }


    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 1, delay: 0.2 , options: .allowAnimatedContent, animations: {
            cell.layer.transform = CATransform3DIdentity
        })

    }
    
}


extension ViewController: UITableViewDelegate{
    
   
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.imageViewInCell.image = UIImage(named: String(indexPath.row))
        return cell
        
    }
    
    
    
    
}
