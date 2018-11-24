//
//  CoreDataViewController.swift
//  todoApp
//
//  Created by minsoo kim on 22/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

//기존의 MainViewController는 Table View 등의 다른 역할이 있으니, Core data는 독립적인 코드로 짜려함. -> 기존 MainViewController의 Subclass 생성

import UIKit
import CoreData

class CoreDataViewController: MainViewController
{
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 }
    
    var list = [todoItem]()
    
    override func refreshDataBase(with itemList: [todoItem]){
        super.refreshDataBase(with: itemList)
        updateDataBase(with: itemList)
    }
    
    private func updateDataBase(with items:[todoItem]) {
        //DataBase를 백그라운드에서 동작하게 한다.
        container?.performBackgroundTask {[weak self]context in
            for oneItem in items{
                //add Item
                _ = try? TodoItems.findOrCreateItem(matching: oneItem, in: context)
            }
            print("Done Loading database")
            self?.printDataBaseStatistics()
        }
        
    }
    //항상 내용을 확인하려면, Context를 항상 필요로 함.
    private func printDataBaseStatistics() {
        //viewContext는 MainThread Context임.
        // 근데 아래의 내용을 Main Thread에 돌아가니 문제
        
        if let context = container?.viewContext {
            //context.perform은 안전한 Thread에서 동작하게 함.
            context.perform {
                if Thread.isMainThread{
                    print("on Main Thread")
                }else{
                    print("off Main Thread")
                }
                if let itemCount = (try? context.fetch(TodoItems.fetchRequest()))?.count{
                    print("\(itemCount) items")
                }
                
            }
        }
    }
    override func loadDataBase() {
        super.loadDataBase()
       if let context = container?.viewContext {
        context.perform{
            let databaseTodoItems = try? context.fetch(TodoItems.fetchRequest())
            for item in databaseTodoItems as! [TodoItems]{
                var itemToAppend = todoItem()
                itemToAppend.itemTitle = item.itemTitle
                itemToAppend.workNotDone = item.workNotDone
                itemToAppend.notRemoved = item.notRemoved
                itemToAppend.madeTime = item.madeTime
                self.ItemList.append(itemToAppend)
            }
        }
    }
}
}
