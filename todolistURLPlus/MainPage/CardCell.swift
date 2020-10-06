//
//  CardCell.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    let fontName = "Reeji-CloudKaiXing-GB-Regular"
    var data : GetCardResponse.ShowCard!
    lazy var cardTitle: UILabel =
        {
            let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
                                              y: self.frame.height * 0.1,
                                              width: self.frame.width * 0.8,
                                              height: self.frame.height * 0.8))
            label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
            label.font = UIFont(name: self.fontName, size: self.frame.width * 0.1)
            label.numberOfLines = 0
            label.clipsToBounds = true
            label.textAlignment = .left
            return label
        }()
    lazy var subText: UILabel =
        {
            let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
                                              y: self.frame.height * 0.1,
                                              width: self.frame.width * 0.8,
                                              height: self.frame.height * 0.8))
            label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
            label.font = UIFont(name: self.fontName, size: self.frame.width * 0.05)
            label.clipsToBounds = true
            label.textAlignment = .left
            label.numberOfLines = 0
            
            
            return label
        }()
    lazy var subText2: UILabel =
        {
            let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
                                              y: self.frame.height * 0.1,
                                              width: self.frame.width * 0.8,
                                              height: self.frame.height * 0.8))
            label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
            label.font = UIFont(name: self.fontName, size: self.frame.width * 0.05)
            label.clipsToBounds = true
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()

    lazy var longPress: UILongPressGestureRecognizer =
        {
            let press = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressAction))
            press.minimumPressDuration = 1.0
            return press
        }()
    var deleteButton: UIImageView =
        {
            let imageView = UIImageView()
            imageView.center = CGPoint(x: 10, y: 10)
            imageView.frame.size = CGSize(width: ScreenSize.width.value * 0.15,
                                          height: ScreenSize.width.value * 0.15)
            
            imageView.image = UIImage(systemName: "xmark.circle")
            imageView.isHidden = true
            imageView.tintColor = .red
            
            return imageView
        }()
    
    lazy var backgroundCard:UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    var buttonTag = 0
    
    
    var deleteButtonIsHidden = true
    @objc func longPressAction()
    {
        if longPress.state == .began
        {
            
            feedbackGenerator.impactOccurred()
            
            deleteButtonIsHidden = false
            deleteButton.isHidden = deleteButtonIsHidden
            
        }else if longPress.state == .ended
        {
            print("long press end")
            
        }
        
    }
    @objc func btnTag()
    {
        print(self.deleteButton.tag,"||",self.buttonTag)
        
    }
    
    func setupSingle(showCards: [GetCardResponse.ShowCard], indexPath: IndexPath?, state: Bool)
    {
        if let indexPath = indexPath
        {
            self.data = showCards[indexPath.row]

            setLayer()
            let  dateStrarry = data.createdAt.components(separatedBy: ["-","T"])
            let dataStr = dateStrarry[0] + "/" + dateStrarry[1] + "/" + dateStrarry[2]
            
            self.cardTitle.text = "\(data.cardName)"
            self.subText.text = "CreateBy: " + "\(data.createUser)"
            self.subText2.text = "CreateAt: " + "\(dataStr)"
            let myBackgroundView = GlassFactory.makeGlass(style: .systemUltraThinMaterial)
            self.backgroundView = myBackgroundView
            self.deleteButton.isHidden = state
            
            addSubview(cardTitle)
            addSubview(subText)
            addSubview(subText2)
            
            self.addGestureRecognizer(longPress)
            setConstraints()
            
            self.addSubview(deleteButton)
        }
    }
    
    func setupMutiple(showCards: [GetCardResponse.ShowCard], indexPath: IndexPath?, state: Bool)
    {
        if let indexPath = indexPath
        {
            self.data = showCards[indexPath.row]
            setLayer()
            
            let  dateStrarry = data.createdAt.components(separatedBy: ["-","T"])
            let dataStr = dateStrarry[0] + "/" + dateStrarry[1] + "/" + dateStrarry[2]
            
            self.cardTitle.text = "\(data.cardName)"
            self.subText.text = "CreateBy: " + "\(data.createUser)"
            self.subText2.text = "CreateAt: " + "\(dataStr)"
            let myBackgroundView = GlassFactory.makeGlass(style: .regular)
            self.backgroundView = myBackgroundView
            self.deleteButton.isHidden = state
            
            addSubview(cardTitle)
            addSubview(subText)
            addSubview(subText2)
            
            self.addGestureRecognizer(longPress)
            setConstraints()
            
            self.addSubview(deleteButton)
        }
        
    }
    func setConstraints(){
        cardTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset( -20)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        subText.snp.makeConstraints { (make) in
            // make.top.equalTo(cardTitle.snp.bottom).offset(10)
            make.bottom.equalTo(subText2.snp.top).offset(-10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        subText2.snp.makeConstraints { (make) in
            //make.top.equalTo(cardID.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    func setLayer(){
        layer.cornerRadius = self.frame.width * 0.05
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.gray.cgColor
    }
}
