//
//  DriveViewController.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit
import GoogleMaps

class DriveViewController: UIViewController {
    
    @IBOutlet weak var itineraryTableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    @IBOutlet weak var proposalsCollectionView: UICollectionView!
    
    var currentLocation : CLLocation?
    var selectedLocation : Location?
    
    private var proposals : [Proposal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        setUpUI()
        
        NetworkService.shared.getProposalsData { proposals in
            self.proposals = proposals
        }
        
    }
    
    private func setUpMap() {
        mapView.delegate = self
        guard let currentCoordinate = currentLocation?.coordinate else { return }
        guard let targetCoordinate = selectedLocation?.location?.coordinate else { return }
        let bounds = GMSCoordinateBounds(coordinate: currentCoordinate, coordinate: targetCoordinate)
        let camera = mapView.camera(for: bounds, insets: UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20))
        if let camera = camera {
            mapView.camera = camera
        }
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let markerCurrent = GMSMarker(position: currentCoordinate)
        markerCurrent.icon = UIImage(named: "Pickup Marker")
        markerCurrent.map = mapView
        
        let markerTarget = GMSMarker(position: targetCoordinate)
        markerTarget.icon = UIImage(named: "DropOff Marker")
        markerTarget.map = mapView
    }
    
    
    private func setUpUI() {
        itineraryTableView.delegate = self
        itineraryTableView.dataSource = self
        itineraryTableView.rowHeight = 60
        itineraryTableView.layer.shadowColor = UIColor.lightGray.cgColor
        itineraryTableView.layer.shadowOffset = CGSize(width:0,height: 2.0)
        itineraryTableView.layer.shadowRadius = 2
        itineraryTableView.layer.shadowOpacity = 1.0
        itineraryTableView.layer.masksToBounds = false
        itineraryTableView.isScrollEnabled = false
        let nibUser = UINib(nibName: "UserLocationTableViewCell", bundle: nil)
        itineraryTableView.register(nibUser, forCellReuseIdentifier: Identifiers.userLocationCellIdentifier)
        view.bringSubviewToFront(itineraryTableView)
        
    }
    
    
    
}

extension DriveViewController: GMSMapViewDelegate {
    
}

extension DriveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itineraryTableView.dequeueReusableCell(withIdentifier: Identifiers.userLocationCellIdentifier, for: indexPath) as! UserLocationTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.infoImage.image = UIImage(named: "Marker")
            cell.infoImage.image = cell.infoImage.image!.withRenderingMode(.alwaysTemplate)
            cell.infoImage.tintColor = Colors.turquoise
        case 1:
            cell.infoImage.image = UIImage(named: "Marker")
            cell.infoLabel.textColor = .black
            cell.infoLabel.text = selectedLocation?.address
        default:
            break
        }
        return cell
    }
    
    
}
