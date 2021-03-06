//
//  FetchData.swift
//  where2meet
//
//  Created by Gregory peppel on 11/13/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var venuesTableView: UITableView!
    
    // Central Park --> NYC coords
    let CPLatitude: Double  = 40.782483
    let CPLongitude: Double = -73.963540
    // list to hold yelp data
    var venues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
        venuesTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        venuesTableView.separatorStyle = .none
        
        fetchVenues(latitude: CPLatitude, longitude: CPLongitude, category: "gyms",
                       limit: 20, sortBy: "distance", locale: "en_US") { (response, error) in
                        
                        if let response = response {
                            self.venues = response
                            DispatchQueue.main.async {
                                self.venuesTableView.reloadData()
                            }
                        }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        cell.nameLabel.text = venues[indexPath.row].name
        cell.ratingLabel.text = String(venues[indexPath.row].rating ?? 0.0)
        cell.priceLabel.text = venues[indexPath.row].price ?? "-"
        cell.isClosed = venues[indexPath.row].is_closed ?? false
        cell.addressLabel.text = venues[indexPath.row].address
        
        return cell
    }
}



