//
//  CardEditVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditVC: CanLoadViewController {
    private var funtionType:TaskModel.FuntionType?
    private var cardID:Int = 0
    private var taskID:Int?
    private let cardEditView = CardEditView()
    
    override func loadView() {
        super.loadView()
        view = cardEditView
    }
    override func viewWillAppear(_ animated: Bool) {
       navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pushGlass()
        setNC()
        print("isLoaded")
    }
    
    func setNC(){
        print(#function)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(save))
        self.navigationItem.title = "test"
    }
    @objc func save(){
        switch funtionType {
        case .create:
            print("create")
            createTask()
        case .edit:
            print("save")
            saveTask()
        case .delete:
            print("delete")
            break
        case .none:
            break
        }
    }
    private func refreshColor(color:ColorsButtonType){
        self.cardEditView.refreshColor(color: color)
        self.cardEditView.colorsCollectionView.delegate = self
        self.cardEditView.scrollView.delegate = self
        self.cardEditView.textView.delegate = self
        self.cardEditView.colorsCollectionView.reloadData()
        //        self.view = cardEditView
    }
    func createPage(cardID:Int){
        let viewData:TaskModel = {
                   var viewData = TaskModel()

                       viewData.tag = .red
                       self.funtionType = .create
                       viewData.description = "Please input"
                       viewData.image = UIImage(systemName: "photo")!
                       viewData.title = ""

                   self.cardID = cardID
                   return viewData
               }()
               self.cardEditView.colorsCollectionView.delegate = self
               self.cardEditView.scrollView.delegate = self
               self.cardEditView.textView.delegate = self
               self.cardEditView.colorsCollectionView.reloadData()
               self.cardEditView.setUserData(data: viewData)
    }
    func editPage (taskID:Int,title:String?,description:String?,image:String?,tag:ColorsButtonType?){
        let viewData:TaskModel = {
            var viewData = TaskModel()
            viewData.taskID = taskID
            viewData.title = title ?? ""
            viewData.description = description ?? ""
            viewData.funtionType = .edit
            if let image = image{
                getImage(type: .gill, imageURL: image, completion: { (image) in
                viewData.image = image
            })
            }else{
                viewData.image = UIImage(systemName: "photo")
            }
            viewData.tag = tag ?? ColorsButtonType.red
            return viewData
        }()
             self.taskID = taskID
              self.cardEditView.colorsCollectionView.delegate = self
              self.cardEditView.scrollView.delegate = self
              self.cardEditView.textView.delegate = self
              self.cardEditView.colorsCollectionView.reloadData()
              self.cardEditView.setUserData(data: viewData)
    }
    
    private func saveTask(){
        loading()
        TaskModelManerger.edit(cardID, taskID!, cardEditView) {
            self.popView()
        }
    }
    private func createTask(){
        loading()
        TaskModelManerger.create(cardID,cardEditView) {
            self.popView()
        }
    }
    @objc func deleteTask(){
        loading()
        TaskModelManerger.delete(taskID!) {
             self.popView()
        }
       
    }
    @objc func takeImage() {
        DispatchQueue.main.async{
            let photoController = UIImagePickerController()
            photoController.delegate = self
            photoController.sourceType = .photoLibrary
            self.present(photoController, animated: true, completion: nil)
        }
    }
    func popView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
extension CardEditVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorType = ColorsButtonType.allCases[indexPath.row]
        cardEditView.refreshColor(color: colorType)
        cardEditView.colorsCollectionView.reloadData()
    }
}
extension CardEditVC:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
extension CardEditVC:UITextViewDelegate{
    func textViewDidChange(_ textView:UITextView) {
        
        resetHight(textView)
        
    }
    func resetHight(_ textView:UITextView){
        let maxHeight:CGFloat = ScreenSize.height.value * 0.4
        let frame = textView.frame
        let constrainSize=CGSize(width:frame.size.width,height:CGFloat(MAXFLOAT))
        var size = textView.sizeThatFits(constrainSize)
        if size.height >= maxHeight{
            size.height = maxHeight
            textView.isScrollEnabled=true
        }else{
            textView.isScrollEnabled=false
        }
        textView.frame.size.height=size.height
    }
}
extension CardEditVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        loading()
        if let image = info[.originalImage] as? UIImage{
            let _image = UIImage(data: image.jpegData(compressionQuality: 0.05)!)
            print("origin", image.pngData())
            print("resize", _image?.pngData())
            cardEditView.imageView.image = _image
        }
        stopLoading()
        dismiss(animated: true, completion: nil)
    }
}
