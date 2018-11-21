//
//  TodoItemTableViewCell.swift
//  todoApp
//
//  Created by minsoo kim on 21/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

protocol OptionButtonsDelegate{
    func workDoneTapped(at index:IndexPath)
}

class TodoItemTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK : 진짜 전혀 모르는 내용이다 - Protocol과 delegate  복습필요함.
    var delegate:OptionButtonsDelegate!
    var indexPath: IndexPath!
    @IBAction func checkButton(_ sender: UIButton) {
        print("touched!resf")
        self.delegate?.workDoneTapped(at: indexPath)
    }
    
    @IBOutlet weak var checkButtonShape: UIButton!
    @IBOutlet weak var itemTitle: UILabel!
    
}
