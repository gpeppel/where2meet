//
//  FetchData.swift
//  where2meet
//
//  Created by Gregory peppel on 11/13/21.
//

import Foundation

extension ViewController {

    func fetchVenues(latitude: Double,
                     longitude: Double,
                     category: String,
                     limit: Int,
                     sortBy: String,
                     locale: String,
                     completionHandler: @escaping ([Venue]?, Error?) -> Void) {
        
        // yelp api
        let apiKey = ""
        
        // fetch business endpoint
        let baseURL = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
        
        // create url
        let url = URL(string: baseURL)
        
        // GET request
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // fetch response from yelp endpoint
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                guard let resp = json as? NSDictionary else { return }
                
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return }
                // store data
                var venuesList: [Venue] = []
                
                for business in businesses {
                    var venue = Venue()
                    venue.name = business.value(forKey: "name") as? String
                    venue.id = business.value(forKey: "id") as? String
                    venue.rating = business.value(forKey: "rating") as? Float
                    venue.price = business.value(forKey: "price") as? String
                    venue.is_closed = business.value(forKey: "is_closed") as? Bool
                    venue.distance = business.value(forKey: "distance") as? Double
                    let address = business.value(forKeyPath: "location.display_address") as? [String]
                    venue.address = address?.joined(separator: "\n")
                    
                    venuesList.append(venue)
                }
                
                completionHandler(venuesList, nil)
            }
            catch {
                print("Caught error!")
                completionHandler(nil, error)
            }
        }.resume()
    }
}
