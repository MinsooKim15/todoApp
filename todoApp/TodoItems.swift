//
//  TodoItems.swift
//  todoApp
//
//  Created by minsoo kim on 21/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

//TODO : Model생성시(또는 파일 생성시) 첫문자 대글자 규칙이 있는지 확인이 필요함.

import UIKit
import CoreData

//TODO : 아래의 TodoItems는 단일한 TODO Item을 의미하는 Core Data Model임. 다른 기존의 Data와 겹치는 모델로 변경해야 함.
class TodoItems: NSManagedObject {
    class func findOrCreateItem(matching ItemInfo: todoItem, in context: NSManagedObjectContext) throws -> TodoItems
    {
        //먼저 기존 Item이 있는지 찾는다.
        let request: NSFetchRequest<TodoItems> = TodoItems.fetchRequest()
        request.predicate = NSPredicate(format: "itemTitle= %@", ItemInfo.itemTitle!)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0{
                //TODO : ID로 변경하고, 아래의 Sanity assertion 해제
                //                assert(matches.count > 1,"database inconsistency")
                //위에서는 스트링을 사용하니 상관이 없지만, ID를 쓴다면 Unique하기 때문에 두 개 이상이 있으면 DataBase가 문제가 있으니, 에러 메시지가 있어야 함.
                return matches[0]
            }
            try? context.save()
        } catch {
            throw error
        }
        //위 Do Let Function에 Return이 있으니, 이 밑으로 내려오는 경우는  DB에 값이 없는 경우임. 즉, 새롭게 만들어야 함.
        
        let item = TodoItems(context:context)
        item.itemTitle = ItemInfo.itemTitle
        item.madeTime = ItemInfo.madeTime
        item.notRemoved = ItemInfo.notRemoved
        item.workNotDone = ItemInfo.workNotDone
        return item
    }
}
