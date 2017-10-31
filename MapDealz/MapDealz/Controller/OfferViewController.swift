//
//  ViewController.swift
//  Mapdealz
//
//  Created by Soeb on 10/19/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit
import GoogleSignIn

class OfferViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let menuSlide = MenuSlideAnimation()
    
    let locationManager = CLLocationManager()
    
    let collectionDataSource = CollectionDataSourceManager()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        //Setup Navigation Bar
        setupNavigation()
        collectionView?.dataSource = collectionDataSource
        collectionView?.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        collectionView?.register(OfferCollectionCell.self, forCellWithReuseIdentifier: "cellId")
    
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width * 0.48), height: 200)
    }
    
    
    func setupNavigation() {
        navigationItem.title = "MapDealz"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleMenuClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }

    
    @objc func handleLogout() {
        let loginController = LoginViewController()
        GIDSignIn.sharedInstance().signOut()
        present(loginController, animated: true, completion: nil)
    }
 
    
    @objc func handleMenuClick() {
        let menuController = MenuViewController()
        menuController.transitioningDelegate = menuSlide
        present(menuController, animated: true, completion: nil)
    }
    

    
}


extension OfferViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        print("location = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            locationManager.stopMonitoringSignificantLocationChanges()
            return
        }
        
        // Notify User of the error
    }
}
