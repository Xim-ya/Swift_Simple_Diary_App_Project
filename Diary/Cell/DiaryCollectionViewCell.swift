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
        label.textColor = UIColor(named: "DarkGrey")
        label.text = "여기에는 내용이 들어갑니다 네 여기에는 내용이 들어가요  네 여기에는 내용이 들어가요"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3

        return label
        
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "DarkGrey")
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setContentViewConfig()
        setCellContentsLayout()
    }
    
    private func setCellContentsLayout() {
        /* Title */
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        /* Contents Description */
        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        /* Date */
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
    
    private func setContentViewConfig() {
        /* Corner Radius Border */
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        contentView.layer.cornerRadius = 12

        /* Add SubViews */
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
}
