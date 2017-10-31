//
//  ChatLogController.swift
//  friends
//
//  Created by Soeb on 2/17/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout {
    
    var user:User? {
        didSet {
            navigationItem.title = user?.name
            observeMessages()
        }
    }
    
    var messages = [Message]()
    
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter Message..."
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        return text
    }()
    
    let sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Send", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return btn
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            collectionView?.backgroundColor = UIColor.white
            collectionView?.alwaysBounceVertical = true
            collectionView?.contentInset = UIEdgeInsetsMake(8, 0, 54, 0)
            collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 54, 0)
            // Add Conatiner View to hold TextField and Send button
            view.addSubview(containerView)
            setupContainterView()
            view.addSubview(seperatorView)
            setupSeperatorView()
            collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: "cellId")
        
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ChatMessageCell
        let message = messages[indexPath.item]
        setupCell(cell: cell!, message: message)
        cell?.textView.text = message.text
        cell?.bubbleWidthAnchor?.constant = estimateFrameForText(text: message.text!).width + 32
        return cell!
        
    }
    
    private func setupCell(cell: ChatMessageCell, message: Message) {
        if let profileImageUrl = user?.profileImage {
            cell.profileImageView.loadImageUsingUrl(urlString: profileImageUrl)
        }
        
        if message.fromId == FIRAuth.auth()?.currentUser?.uid {
            cell.bubbleView.backgroundColor = UIColor(red: 0, green: 137, blue: 249)
            cell.textView.textColor = .white
            cell.profileImageView.isHidden = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.bubbleRightAnchor?.isActive = true

        } else {
            cell.bubbleView.backgroundColor = UIColor.lightGray
            cell.profileImageView.isHidden = false
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
            cell.textView.textColor = .black
        }
        

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        // get estimated height somehow??
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text: text).height + 20
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimateFrameForText(text:String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)] , context: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    func handleSend () {
        
        if messageTextField.text != nil {
            let ref = FIRDatabase.database().reference().child("messages")
            let childRef = ref.childByAutoId()
            let fromId = FIRAuth.auth()?.currentUser?.uid
            let toId = user?.id
            let timestamp:Int = Int(NSDate().timeIntervalSince1970)
            let values = ["text":messageTextField.text!,"toId": toId!,"fromId":fromId!,"timestamp":timestamp] as [String : Any]
            
            childRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
                
                let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(fromId!)
                let messageId = childRef.key
                userMessagesRef.updateChildValues([messageId: 1])
                let recipientUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toId!)
                recipientUserMessageRef.updateChildValues([messageId: 1])
            })
            messageTextField.text = ""
        }
        
        
    }
    
    func observeMessages() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(uid)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messagesRef = FIRDatabase.database().reference().child("messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let message = Message()
                //potential of crashing if few don`t match
                message.setValuesForKeys(dictionary)
                if message.chatPartnerId() == self.user?.id {
                    self.messages.append(message)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    func setupContainterView () {
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        containerView.addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant: -8).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(messageTextField)
        messageTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 20).isActive = true
        messageTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        messageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        messageTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    }
    
    func setupSeperatorView() {
        
        seperatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
}
