//
//  CategorieCollectionViewCell.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/11/22.
//

import UIKit

class CategorieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var categoryButtom: UIButton! {didSet {
        setNeedsDisplay(); setNeedsLayout()
        categoryButtom.layer.borderColor = UIColor.systemBlue.cgColor
        categoryButtom.layer.borderWidth = 2
        categoryButtom.layer.cornerRadius = 15
        categoryButtom.layer.cornerCurve = .circular
        categoryButtom.layer.maskedCorners = .layerMaxXMaxYCorner
       
    }}
    
    
    
}
