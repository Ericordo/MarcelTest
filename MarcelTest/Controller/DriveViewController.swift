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
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var proposalsCollectionView: UICollectionView!
    
    private var currentLocation : CLLocation?
    private var selectedLocation : Location?
    private var proposals : [Proposal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        setUpUI()
        
        NetworkService.shared.getProposalsData { proposals in
            self.proposals = proposals
            self.proposalsCollectionView.reloadData()
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
        
        proposalsCollectionView.delegate = self
        proposalsCollectionView.dataSource = self
        proposalsCollectionView.isScrollEnabled = false
        let nibProposal = UINib(nibName: "ProposalCollectionViewCell", bundle: nil)
        proposalsCollectionView.register(nibProposal, forCellWithReuseIdentifier: Identifiers.proposalCellIdentifier)
        
        confirmButton.backgroundColor = Colors.darkBlue
        confirmButton.layer.cornerRadius = 10
        
        let layout = UICollectionViewFlowLayout()
        proposalsCollectionView.collectionViewLayout = layout
    }
}

extension DriveViewController: GMSMapViewDelegate {}

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

extension DriveViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = proposalsCollectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.proposalCellIdentifier, for: indexPath) as! ProposalCollectionViewCell
        
        let range = proposals?[indexPath.row].range
        cell.rangeLabel.text = range?.capitalizingFirstLetter()
        let price = Int(proposals?[indexPath.row].price ?? 0)
        cell.priceLabel.text = String(price) + " €"
     
        if range == "eco" {
            cell.leafImageView.image = UIImage(named: "Leaf")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let waitingTime = proposals![indexPath.row].waitingTime else { return }
        waitingTimeLabel.text = "    Temps d'attente estimé à " + String(waitingTime) + " minutes."
    }
}

extension DriveViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/3, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
