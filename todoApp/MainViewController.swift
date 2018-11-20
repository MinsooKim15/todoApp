//
//  ViewController.swift
//  todoApp
//
//  Created by minsoo kim on 19/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    var ItemList = [todoItem]()
    
    @IBOutlet weak var nameOfUser: UILabel!
    
    @IBOutlet weak var todoItemName: UITextField!
    
    @IBAction func saveItem(_ sender: UIButton) {
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
    //Table View 관련 정의
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = ItemList[indexPath.row].itemTitle
        return cell
    }
    
    
    
    @IBOutlet weak var todoTableView: UITableView!
}

