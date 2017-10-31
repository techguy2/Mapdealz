//
//  HomeController.swift
//  VideoApp
//
//  Created by Soeb on 1/27/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var videos:[VideoData] = {
       var channelName = Channel()
       channelName.name = "Kanye West"
       channelName.profileImageName = "profile"
       
       let blankSpaceVideo = VideoData()
       blankSpaceVideo.title = "Taylor Swift - Blank Space"
       blankSpaceVideo.channel = channelName
       return [blankSpaceVideo]
    }()
    
    
    let menuBar : MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.white
        navigationItem.title = "Home"
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        setupMenuBar()
        setupNavBarItem()
        VideoData.callApi()
        
    }
    
    func setupNavBarItem(){
        let searchImage = #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal)
    
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, landscapeImagePhone: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreButton, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    
    func handleSearch(){
        print(123)
    }
    
    func handleMore(){
        print(1234)
    }

    private func setupMenuBar(){
       view.addSubview(menuBar)
       view.addConstraintFormat(format: "H:|[v0]|", views: menuBar)
       view.addConstraintFormat(format: "V:|[v0(40)]|", views: menuBar)
    }
    // Method determine number of Section
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    // Number of Cells in Each Section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    
    // Set the Size of Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 68 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

