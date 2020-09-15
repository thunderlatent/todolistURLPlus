//
//  Cell.swift
//  tableViewCell
//
//  Created by 陳冠諭 on 2020/9/10.
//  Copyright © 2020 KuanYu. All rights reserved.
//


import UIKit

class ListTableViewCell: UITableViewCell {
    
    var cellTitleLabel = UILabel()
    var littleBall = UIView()
//    var backGroundView = UIView()
    var littleBallColor = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 1, green: 0.4348993301, blue: 0, alpha: 1),#colorLiteral(red: 0.9809144139, green: 0.9119312763, blue: 0, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.4235294118, green: 0.6, blue: 0.7882352941, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
    var fullScreenMaxY = UIScreen.main.bounds.maxY
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        setLittleCircle()
        setTitleLabel()
        setTitleCircleConstriants()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }
    
    func setTitleLabel(){
        cellTitleLabel.backgroundColor = .clear
         addSubview(cellTitleLabel)
    }
    
    func setLittleCircle() {
        littleBall.layer.cornerRadius = fullScreenMaxY * 0.0155
        littleBall.backgroundColor = littleBallColor[0]
        addSubview(littleBall)
    }
    
    
    func setTitleLabelConstraints(){
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellTitleLabel.leadingAnchor.constraint(equalTo: littleBall.trailingAnchor, constant: 10).isActive = true
    }
    
    func setTitleCircleConstriants(){
        littleBall.translatesAutoresizingMaskIntoConstraints = false
        littleBall.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        littleBall.widthAnchor.constraint(equalToConstant: fullScreenMaxY * 0.03).isActive = true
        littleBall.heightAnchor.constraint(equalToConstant: fullScreenMaxY * 0.03 ).isActive = true
        littleBall.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    }
    func setUpCell(data: MainModel, indexPath: IndexPath)
    {
        if let task = data.taskModel?[indexPath.section]
        {
        self.backgroundColor = .clear
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
            self.cellTitleLabel.text = task.title
        }
    }
}


