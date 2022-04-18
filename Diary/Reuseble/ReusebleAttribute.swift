

import UIKit

class ReusebleAttribute {
    // MARK: Reusble Attribute Functions
    /// Sectino Title
    static func sectionTitleLabelAttr(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }
    
    /// Rounded Table View
    static func roundTableViewAttr(_ isRoutedForDetail: Bool) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.isEditable = !isRoutedForDetail
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.isScrollEnabled = false
        
        return textView
    }
    
    /// UIButton in GroupButton
    static func singeGroupButton(btnTitle: String, color: UIColor) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = btnTitle
        config.baseForegroundColor = color
        
        let btn = UIButton(configuration: config, primaryAction: nil)
     
        
        return btn
    }
    
    /// Grid Collection View
    static func collectionViewAttr() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: DiaryCollectionViewCell.cellID)
        
        return collectionView
    }
}
