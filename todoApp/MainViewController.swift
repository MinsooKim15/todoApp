//
//  ViewController.swift
//  todoApp
//
//  Created by minsoo kim on 19/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, OptionButtonsDelegate  {

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var ItemList = [todoItem](){
        didSet{
            todoTableView.reloadData()
        }
    }
    
    @IBOutlet weak var nameOfUser: UILabel!
    
    @IBOutlet weak var todoItemName: UITextField!{
        didSet{
            loadDataBase()
        }
    }
    func loadDataBase(){
        // this is implemented in the subclass
        print("loadDataBase")
    }
    
    @IBAction func saveItem(_ sender: UIButton) {
        saveTodoItems(sender)
        refreshDataBase(with: ItemList)
    }
    
    func saveTodoItems(_ sender:UIButton){
        if let text = todoItemName.text {
            let TodoItem = todoItem(text)
            ItemList.append(TodoItem)
        }else{
            let text = ""
            let TodoItem = todoItem(text)
            ItemList.append(TodoItem)
        }
        todoItemName.text = nil
        print(ItemList)
        todoTableView.reloadData()
    }
    func refreshDataBase(with itemList: [todoItem]){
        print("refreshDataBase super-loaded")
    }
    
    //Table View 관련 정의
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemList.count
    }
    
    let checkbuttonNotDone = UIImage(named:"notDoneWork" )
    let checkbuttonDone = UIImage(named:"doneWork" )
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = todoTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoItemTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        let item  = ItemList[indexPath.row]
        cell = workDoneNotDoneStyleChange(item: item, cell: cell)
        return cell
    }
    
    func workDoneNotDoneStyleChange(item : todoItem, cell:TodoItemTableViewCell) -> (TodoItemTableViewCell){
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.itemTitle!)
        if item.workNotDone{
            cell.checkButtonShape.setImage(checkbuttonNotDone, for: .normal)
        }else{
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.checkButtonShape.setImage(checkbuttonDone, for: .normal)
        }
        cell.itemTitle?.attributedText = attributeString
        return cell
    }
    
    //delegate로 todoItemviewcell 적용
    func workDoneTapped(at index: IndexPath) {
        print("WorkDone!")
        ItemList[index.row].workNotDone = !ItemList[index.row].workNotDone
        todoTableView.reloadData()
    }
   
    
    @IBOutlet weak var todoTableView: UITableView!
}

