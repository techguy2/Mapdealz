//
//  ListCell.swift
//  friends
//
//  Created by Soeb on 2/14/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit
import Firebase

class ListCell: UITableViewCell {
    
    var message:Message? {
        didSet {
            setupNameAndProfileImage()
            self.detailTextLabel?.text = message?.text

            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
            }
            
        }
    }
    
    func setupNameAndProfileImage() {
        
        if let id = message?.chatPartnerId() {
            let ref =  FIRDatabase.database().reference().child("users").child(id)
            ref.observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel?.text = dictionary["name"] as? String
                    self.downloadImageView.loadImageUsingUrl(urlString: (dictionary["profileImage"] as? String)!)
                }
            }, withCancel: nil)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width , height: detailTextLabel!.frame.height)
        
    }
    
    let downloadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(downloadImageView)
        
        //Add iOS x, y, w, h constraints
        
        downloadImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        downloadImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        downloadImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        downloadImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        addSubview(timeLabel)
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -2).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
    }
    
}
