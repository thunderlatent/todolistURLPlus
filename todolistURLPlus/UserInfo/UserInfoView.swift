import UIKit

class UserInfoView: UIView {
    var backgroundImage : UIImageView = {
        var uiImage = #imageLiteral(resourceName: "backgroundBlurred")
        var imageView = UIImageView(image: uiImage, highlightedImage: nil)
        imageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.hight.value)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var glassView : UIView = {
        var glassView = UIView (frame: CGRect(x:0, y:0, width: ScreenSize.width.value * 0.9, height: ScreenSize.hight.value * 0.8))
        glassView.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value + ScreenSize.hight.value * 0.04)
        glassView.backgroundColor = .glassColor
        glassView.layer.cornerRadius = 15
        let centerPointX = glassView.center.x - ScreenSize.width.value * 0.05
        let glassViewBotton = glassView.center.y + glassView.frame.height * 0.5 - ScreenSize.hight.value * 0.2
        return glassView
    }()
    var peopleView:UIImageView = {
        var imageView = userImageFactory.makeImageView(size: .medium, image: nil)
        imageView.backgroundColor = .gray
        return imageView
    }()
    var userNameLabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenSize.width.value * 0.3 , height: ScreenSize.hight.value * 0.1))
        label.contentMode = .center
        label.text = "Name"
        label.font = .systemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    var informationButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text: "information")
        return button
    }()
    var modifyPasswordButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text:
            "modify password")
        return button
    }()
    var logoutButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .cancel, text: "logout out")
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubView()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        addSubview(backgroundImage)
        addSubview(glassView)
        addSubview(peopleView)
        addSubview(userNameLabel)
        addSubview(informationButton)
        addSubview(modifyPasswordButton)
        addSubview(logoutButton)
    }
    private func setConstraints(){
        let centerX = ScreenSize.centerX.value
        let space = ScreenSize.spaceY.value
        let glassViewTop = ScreenSize.centerY.value + ScreenSize.hight.value * 0.04 - glassView.frame.height * 0.5
        let glassViewBotton = ScreenSize.centerY.value + ScreenSize.hight.value * 0.04 + glassView.frame.height * 0.5
        peopleView.center = CGPoint(
            x: centerX,
            y: glassViewTop + peopleView.frame.height * 0.5 + space)
        userNameLabel.center = CGPoint(
            x: centerX,
            y: peopleView.frame.maxY + userNameLabel.frame.height * 0.5 + space )
        informationButton.center = CGPoint(
            x: centerX,
            y: userNameLabel.frame.maxY + informationButton.frame.height * 0.5 + space * 1.5)
        modifyPasswordButton.center = CGPoint(
            x: centerX,
            y: informationButton.frame.maxY + modifyPasswordButton.frame.height * 0.5 + space)
        logoutButton.center = CGPoint(
            x: centerX,
            y: glassViewBotton - logoutButton.frame.height * 0.5 - space)
    }
    func setUserData(userImage:UIImage?,userName:String?){
        if let userImage = userImage {
            self.peopleView.image = userImage
        }else{
            self.peopleView.image = UIImage(systemName: "photo")
        }
        
        if let userName = userName {
            self.userNameLabel.text = userName
        }else{
            self.userNameLabel.text = "UnKnow"
        }
    }
}