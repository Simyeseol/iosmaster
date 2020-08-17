//
//  SwitchTableViewCell.swift
//  TableView
//
//  Created by yeseol sim  on 16/08/2020.
//  Copyright © 2020 Keun young Kim. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    //여기다가 초기화 코드 구현 .
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let v = UISwitch(frame: .zero)
        accessoryView = v
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
