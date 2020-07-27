//
//  DateTableViewCell.swift
//  LunarCalendar
//
//  Created by NKG on 2019/11/12.
//  Copyright © 2019 NewmanYork. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var lunarLabel: UILabel!
    @IBOutlet var notSuitableLable: UILabel!
    @IBOutlet var suitableLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
