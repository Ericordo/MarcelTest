//
//  ViewController.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit
import GoogleMaps



class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var directionButton: DirectionButton!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    let locationManager = CLLocationManager()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        setUpLocationManager()
        setUpMap()
        setUpUI()
        
        
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
    }
    
    private func setUpMap() {
        mapView.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: MapConstants.defaultLocation.coordinate.latitude,
                                              longitude: MapConstants.defaultLocation.coordinate.longitude,
                                              zoom: MapConstants.zoomLevel)
        mapView.camera = camera
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setUpUI() {
        
        navigationController?.navigationBar.isHidden = true
        favoritesTableView.layer.cornerRadius = 10
        favoritesTableView.backgroundColor = Colors.favoriteCellColor
        let nib = UINib(nibName: "FavoritesTableViewCell", bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: Identifiers.favoriteCellIdentifier)
        favoritesTableView.rowHeight = 60
        view.bringSubviewToFront(favoritesTableView)
        view.bringSubviewToFront(directionButton)
    }
    
    
    @IBAction func didTapDirection(_ sender: DirectionButton) {
        
        
    }
    
    
    
    
    
}

extension HomeViewController: GMSMapViewDelegate {
    
    
}


extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: MapConstants.zoomLevel)
        mapView.animate(to: camera)
        let marker = GMSMarker(position: location.coordinate)
        marker.icon = UIImage(named: "Pickup Marker")
        marker.map = mapView
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: Identifiers.favoriteCellIdentifier, for: indexPath) as! FavoritesTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
}
