//
//  ViewController.swift
//  Countries
//
//  Created by Mohamed Mostafa on 10/11/2021.
//

import UIKit

class ViewController: UIViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://restcountries.com/v3.1/all"
        if let url = URL(string: urlString) {
            
            getData(with: url)
            
        }
    }
    
    func parseJson(json: Data) {
        let decoder = JSONDecoder()
        if let jsonCountries: [Country] = try? decoder.decode([Country].self, from: json) {
            countries = jsonCountries
        }
    }
    
    func getData(with url: URL){
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error loading data")
            } else {
                // parse data
                if let data = data {
                    self.parseJson(json: data)
                }
            }
        })
        dataTask.resume()
    }
    
}

