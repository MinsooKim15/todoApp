//
//  todoItem.swift
//  todoApp
//
//  Created by minsoo kim on 19/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import Foundation

struct todoItem{
    //TODO : ID가 필요하다. 지금은 우선 String Match를 쓰자.
    var itemTitle : String?
    var workNotDone = true
    var notRemoved = true
    var madeTime : Date?
    init(_ title: String){
        self.itemTitle = title
        let date = DateByTimeZone()
        self.madeTime = date
    }
    init(){
    }
    

}

private func DateByTimeZone()->(Date){
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
    formatter.locale = Locale(identifier:"ko_kr")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    let kor_date_string = formatter.string(from:date)
    let kor_date = formatter.date(from: kor_date_string)
    return(kor_date!)
}
