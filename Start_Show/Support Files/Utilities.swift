//
//  Utilities.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/13/22.
//

import UIKit

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


extension UIImageView {
    
    func makeRounded(borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.clear.cgColor) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
        layer.borderColor = borderColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}


