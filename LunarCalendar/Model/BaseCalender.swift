//
//  BaseCalender.swift
//  LunarCalendar
//
//  Created by NKG on 2019/11/13.
//  Copyright © 2019 NewmanYork. All rights reserved.
//

import UIKit

class BaseCalender {

    static private let Zodiacs: [String] = ["鼠", "牛", "虎", "兔", "龍", "蛇", "馬", "羊", "猴", "雞", "狗", "猪"]
    static private let HeavenlyStems: [String] = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    static private let EarthlyBranches: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    
    //取得國曆日期
    static func getSolarDate(date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        return String(calendar.component(.year, from: date))+"/"+String(calendar.component(.month, from: date))+"/"+String(calendar.component(.day, from: date))
    }
    
    //取得農曆日期
    static func getLunarDate(solarDate: Date) -> String {
        let calendar : Calendar = Calendar(identifier: .chinese)
        return String(calendar.component(.year, from: solarDate))+"/"+String(calendar.component(.month, from: solarDate))+"/"+String(calendar.component(.day, from: solarDate))
    }
    
    static func zodiac(withYear year: Int) -> String {
        let zodiacIndex: Int = (year - 1) % Zodiacs.count
        return Zodiacs[zodiacIndex]
    }
    
    //取得生肖
    static func getZodiac(withDate date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return zodiac(withYear: calendar.component(.year, from: date))
    }
     
    
    static func era(withYear year: Int) -> String {
        let heavenlyStemIndex: Int = (year - 1) % HeavenlyStems.count
        let heavenlyStem: String = HeavenlyStems[heavenlyStemIndex]
        let earthlyBrancheIndex: Int = (year - 1) % EarthlyBranches.count
        let earthlyBranche: String = EarthlyBranches[earthlyBrancheIndex]
        return heavenlyStem + earthlyBranche
    }
        
    //取得年柱
    static func getEra(withDate date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return era(withYear: calendar.component(.year, from: date))
    }
    
}
