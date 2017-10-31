//
//  VideoCell.swift
//  VideoApp
//
//  Created by Soeb on 1/27/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    var video:VideoData?{
        didSet{
            titleLabel.text = video?.title
            profileImage.image = UIImage(named: (video?.channel?.profileImageName)!)
        }
    }

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
        }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Soeb Karedia -- Personal Video"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Number of Views - 1.6M Views - 2 Years"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(profileImage)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        
        
        addConstraintFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView,profileImage,seperatorView)
        
        addConstraintFormat(format: "H:|[v0]|", views: seperatorView)
        addConstraintFormat(format: "H:|-16-[v0(44)]|", views: profileImage)
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        addConstraint(NSLayoutConstraint.init(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        addConstraint(NSLayoutConstraint.init(item: subTitleTextView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: subTitleTextView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
