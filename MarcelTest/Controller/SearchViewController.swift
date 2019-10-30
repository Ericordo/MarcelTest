//
//  SearchViewController.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var resultsTableView: UITableView!
    
    private var placesClient: GMSPlacesClient!
    private var searchResults = [SearchResult]()
    private let token = GMSAutocompleteSessionToken.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        placesClient = GMSPlacesClient.shared()
    }
    
    func setUpUI() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = 60
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.rowHeight = 60
        resultsTableView.backgroundColor = Colors.resultsTVColor
        searchTableView.layer.shadowColor = UIColor.lightGray.cgColor
        searchTableView.layer.shadowOffset = CGSize(width:0,height: 2.0)
        searchTableView.layer.shadowRadius = 2
        searchTableView.layer.shadowOpacity = 1.0
        searchTableView.layer.masksToBounds = false
        searchTableView.isScrollEnabled = false
        let nibSearch = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchTableView.register(nibSearch, forCellReuseIdentifier: Identifiers.searchCellIdentifier)
        let nibUser = UINib(nibName: "UserLocationTableViewCell", bundle: nil)
        searchTableView.register(nibUser, forCellReuseIdentifier: Identifiers.userLocationCellIdentifier)
        let nibResult = UINib(nibName: "ResultTableViewCell", bundle: nil)
        resultsTableView.register(nibResult, forCellReuseIdentifier: Identifiers.resultCellIdentifier)
        view.bringSubviewToFront(searchTableView)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == searchTableView {
            return 2
        } else {
            return searchResults.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = searchTableView.dequeueReusableCell(withIdentifier: Identifiers.userLocationCellIdentifier, for: indexPath) as! UserLocationTableViewCell
        let searchCell = searchTableView.dequeueReusableCell(withIdentifier: Identifiers.searchCellIdentifier, for: indexPath) as! SearchTableViewCell
        let resultCell = resultsTableView.dequeueReusableCell(withIdentifier: Identifiers.resultCellIdentifier, for: indexPath) as! ResultTableViewCell
        
        searchCell.textField.delegate = self
        
        if tableView == searchTableView {
            switch indexPath.row {
            case 0:
                return userCell
            case 1:
                return searchCell
            default:
                return userCell
            }
        } else {
            if searchResults.count > 0 {
                resultCell.addressLabel.attributedText = searchResults[indexPath.row].address
                resultCell.cityLabel.attributedText = searchResults[indexPath.row].city
            }
        }
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == resultsTableView {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        autoComplete(query: text)
    }
    
    private func autoComplete(query: String) {
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        placesClient.findAutocompletePredictions(fromQuery: query, bounds: nil, boundsMode: GMSAutocompleteBoundsMode.bias, filter: filter, sessionToken: token) { (results, error) in
            if let error = error {
                print("Autocomplete error", error)
                return
            }
            if let results = results {
                self.searchResults.removeAll()
                results.forEach { result in
                    var searchResult = SearchResult()
                    searchResult.address = result.attributedPrimaryText
                    searchResult.city = result.attributedSecondaryText
                    self.searchResults.append(searchResult)
                }
            }
        }
        resultsTableView.reloadData()
    }
    
    
    
}
