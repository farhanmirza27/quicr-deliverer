//
//  UIComponents.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 23/10/2020.
//


import Foundation
import UIKit

class UIComponents {
    static let shared = UIComponents()
    
    // label
    func label(text : String, alignment: NSTextAlignment = .left, fontName : String = FontName.Regular, fontSize : CGFloat = 14, color : UIColor = AppTheme.secondaryBlack) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: fontName, size: fontSize)
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = 0
        return label
    }
    
    func coloredLabel(text : String, fontName : String = FontName.Regular, fontSize : CGFloat = 14) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: fontName, size: fontSize)
        label.textColor = AppTheme.primaryColor
        return label
    }
    
    // button
    func button(title : String, fontName : String = FontName.Bold, fontSize : CGFloat = 14, cornerRadius : CGFloat = 0, bgColor : UIColor = AppTheme.blue) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = cornerRadius
        button.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        button.layer.cornerRadius = 10
        return button
    }
    
    func secondaryButton(title : String, fontName : String = FontName.Bold, fontSize : CGFloat = 13, titleColor : UIColor = AppTheme.primaryColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        button.layer.cornerRadius = 20 //buttonHeight/2
        return button
    }

    func buttonWithImage(imageName : String , tintColor : UIColor = AppTheme.secondaryBlack) -> UIButton {
           let button  = UIButton(type: .system)
           button.setImage(UIImage(named: imageName), for: .normal)
           button.tintColor = tintColor
           button.backgroundColor = .white
           return button
       }
       
    
    // container
    func container(bgColor : UIColor = .white,cornerRadius : CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        view.layer.cornerRadius = cornerRadius
        return view
    }
    
    // image view
    func ImageView(imageName : String = "", contentMode : UIView.ContentMode = .scaleAspectFill, cornerRadius : CGFloat = 0, tag : Int = 0) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius  = cornerRadius
        imageView.clipsToBounds = true
        imageView.tag = tag
        return imageView
    }
    
   func textfield(placeholder : String, fontName : String = FontName.SemiBold, fontSize : CGFloat = 14) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.font = UIFont(name: fontName, size: fontSize)
        textfield.textColor = AppTheme.black
        textfield.backgroundColor  = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(16)
        return textfield
    }
//
    // MARK: UITextView
    func textView(text : String = "", fontName : String = FontName.Regular, textColor : UIColor = AppTheme.black, fontSize : CGFloat = 14) -> UITextView {
        let textView  = UITextView()
        textView.isEditable = false
        textView.text = text
        textView.font = UIFont(name: fontName, size: fontSize)
        textView.textColor = textColor
        textView.backgroundColor = .clear
        return textView
    }
    
    // table view
    func tableView() -> UITableView {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        return tableView
    }
    
    // Collection View
    func collectionview(lineSpacing : CGFloat = 2, itemSpacing : CGFloat = 0 , withCustomLayout : Bool = false, scrollDirection : UICollectionView.ScrollDirection = .vertical ) -> UICollectionView {
        let cv : UICollectionView = {
            let flowLayout: UICollectionViewFlowLayout = {
                
                let layout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = lineSpacing
                layout.minimumInteritemSpacing = itemSpacing
                layout.scrollDirection = scrollDirection
                
                if #available(iOS 9.0, *) {
                    layout.sectionHeadersPinToVisibleBounds = false
                }
                return layout
            }()
            return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        }()
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }

}


// constants
let buttonHeight : CGFloat = 45
