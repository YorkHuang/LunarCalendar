//
//  DateItem.swift
//  LunarCalendar
//
//  Created by NKG on 2019/11/19.
//  Copyright © 2019 NewmanYork. All rights reserved.
//

import UIKit

class DateItem {
    
    var date : String = ""
    var lundar : String = ""
    var suitable : String = ""
    var notSuitable : String = ""

    init(date:String, lundar:String, suitable:String, notSuitable:String) {
        self.date = date
        self.lundar = lundar
        self.suitable = suitable
        self.notSuitable = notSuitable
    }
}
