//
//  ViewController.swift
//  friends
//
//  Created by Soeb on 2/13/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UITableViewController {
    var messages = [Message]()
    var messageDictionary = [String:Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action:
            #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        tableView.register(ListCell.self, forCellReuseIdentifier: "cellId")
        chekIfUserIsLoggedIn()
    }
    
    func observeUserMessage() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let ref = FIRDatabase.database().reference().child("user-messages").child(uid)
        
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageId)
            
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    let message = Message()
                    message.setValuesForKeys(dictionary)
                    
                    if let chatPartnerId = message.chatPartnerId() {
                        self.messageDictionary[chatPartnerId] = message
                        
                        self.messages = Array(self.messageDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                        })
                    }
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                    
                }
            }, withCancel: nil)
            
            
        }, withCancel: nil)
        

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ListCell
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        guard let chatPartnerId = message.chatPartnerId() else {
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any] {
                let user = User()
                user.setValuesForKeys(dictionary)
                user.id = snapshot.key
                self.showChatControllerForUser(user: user)

            }
            
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    func handleNewMessage(){
        let messageController = NewMessageController()
        messageController.viewController = self
        present(UINavigationController.init(rootViewController: messageController), animated: true, completion: nil)
    }
    
    func chekIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            checkUserAndSetupNavBar()
        }
    }
    
    
    func checkUserAndSetupNavBar() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        
            if let dictionary = snapshot.value as? [String: Any]{
                let user = User()
                user.setValuesForKeys(dictionary)
                self.setupNavBarWithUser(user: user)
            }
       })
    }

    func setupNavBarWithUser(user: User) {
        messages.removeAll()
        messageDictionary.removeAll()
        tableView.reloadData()
        observeUserMessage()
        let titleView = NavTitleView()
        titleView.nameTextField.text = user.name
        titleView.profileImageView.loadImageUsingUrl(urlString: user.profileImage!)
        titleView.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        navigationItem.titleView = titleView
    }
    
    func showChatControllerForUser(user: User) {
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
        
    }
    func handleLogout(){
        do{
            try FIRAuth.auth()?.signOut()
            
        }catch let logoutError{
            print(logoutError)
        }
        let loginController = LoginController()
        loginController.viewController = self
        present(loginController, animated: true, completion: nil)
        
    }

}

