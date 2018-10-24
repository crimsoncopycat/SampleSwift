//
//  DefaultSwiftServicesExtensions.swift
//  instaStatistic
//
//  Created by Jworld Downloads on 5/15/18.
//  Copyright © 2018 iulikB. All rights reserved.
//

import UIKit
extension Date {
    static func getDateStringFormatAs(dateFormat: String , date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = dateFormat
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func getDateFormatAs(dateFormat: String , date: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = dateFormat
        return dateFormatter.date(from: date)!
    }
    
    func dateIsSame(compareWith date : String) -> Bool {
        return Calendar.current.compare(Date.getDateFormatAs(dateFormat: "dd MMM,yyyy" , date: date), to: self, toGranularity: .day) == .orderedSame
    }
}

extension UserDefaults {
    static func isFirstLaunch(flag: String = "hasBeenLaunchedBeforeFlag") -> Bool {
        let hasBeenLaunchedBeforeFlag = flag
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}

extension Array where Element: Equatable {
    func next(item: Element) -> Element? {
        if let index = self.index(of: item), index + 1 <= self.count {
            return index + 1 == self.count ? nil : self[index + 1]
        }
        return nil
    }
    
    func skip(item: Element) -> Element? {
        if let index = self.index(of: item), index + 2 <= self.count {
            return index + 2 == self.count ? nil : self[index + 2]
        }
        return nil
    }
    
    func prev(item: Element) -> Element? {
        if let index = self.index(of: item), index >= 0 {
            return index == 0 ? self.last : self[index - 1]
        }
        return nil
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
extension Bool {
    init<T : BinaryInteger>(_ integer: T) {
        if integer == 0 {
            self.init(false)
        } else {
            self.init(true)
        }
    }
}



