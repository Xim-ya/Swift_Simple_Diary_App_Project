//
//  DiaryCollectionViewCell.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    
    static let cellID: String = "diary"
    
 
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.text = "제목입니다"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: <#T##String#>)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setContentViewConfig()
        setTitleConfig()
    }
    
    private func setTitleConfig() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true

    }
    
    
    private func setContentViewConfig() {
        /* Corner Radius Border */
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        contentView.layer.cornerRadius = 12


        
        /* Add SubViews */
        contentView.addSubview(titleLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
}
