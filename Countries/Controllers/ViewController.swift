//
//  ViewController.swift
//  Countries
//
//  Created by Mohamed Mostafa on 10/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        tableView.backgroundColor = .yellow
        tableView.delegate = self
        tableView.dataSource = self
        
        let urlString = "https://restcountries.com/v3.1/all"
        if let url = URL(string: urlString) {
            
            getData(with: url)
            
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if searchTextField.text == "" {
            guard filteredCountries.count != countries.count else { return }
            filteredCountries.removeAll()
            filteredCountries = countries
        } else {
            filteredCountries.removeAll()
            for country in countries {
                if country.name.common.lowercased().contains(searchTextField.text!.lowercased()){
                    filteredCountries.append(country)
                }
            }
        }
        tableView.reloadData()
    }
    
    
    func parseJson(json: Data) {
        let decoder = JSONDecoder()
        if let jsonCountries: [Country] = try? decoder.decode([Country].self, from: json) {
            countries = jsonCountries
            filteredCountries = countries
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getData(with url: URL){
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error loading data \(String(describing: error))")
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetils" {
            if let destinationVC = segue.destination as? DetailsViewController {
                let indexpath = tableView.indexPathForSelectedRow
                let country = filteredCountries[indexpath!.row]
                destinationVC.name = country.name.common
                destinationVC.capital = country.capital?[0]
                destinationVC.officialName = country.name.official
                destinationVC.continents = country.continents
                destinationVC.flags = country.flags.png
                destinationVC.maps = country.maps.googleMaps
                destinationVC.population = country.population
                destinationVC.startOfWeek = country.startOfWeek
                destinationVC.timezones = country.timezones
                destinationVC.latlong = country.latlng
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.text = filteredCountries[indexPath.row].name.common
        return cell
    }
    
}

