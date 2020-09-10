//
//  ViewController.swift
//  tableViewCell
//
//  Created by 陳冠諭 on 2020/9/10.
//  Copyright © 2020 KuanYu. All rights reserved.
//


import UIKit

class ListBaseView: UIView {
    
    var cellTitle = ["title", "title", "title", "title", "title"]
    var tableView = UITableView()
    var baseView = UIView()
    var fullScreenMaxY = UIScreen.main.bounds.maxY
    
    
    func setTableView(){
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = fullScreenMaxY * 0.105
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
//        tableView.delegate = self
//        tableView.dataSource = self
        self.addSubview(tableView)
    }
    
    func setBaseView(){
        baseView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        baseView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        baseView.layer.cornerRadius = 15
        baseView.layer.borderWidth = 3
        self.addSubview(baseView)
    }
    
    func setTableViewConstriants(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,constant: -10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo:baseView.trailingAnchor, constant: -20 ).isActive = true

            }
    
    func setBaseViewConstriants(){
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        baseView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.67).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10 ).isActive = true
    }
    
    func setView() {
        setBaseView()
        setTableView()
        setTableViewConstriants()
        setBaseViewConstriants()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


