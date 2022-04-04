//
//  DetailsViewController.swift
//  Countries
//
//  Created by Mohamed Mostafa on 20/11/2021.
//


import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    var name: String?
    var officialName: String?
    var capital: String?
    var maps: String?
    var latlong: [Double]?
    var population: Int?
    var timezones: [String]?
    var continents: [String]?
    var startOfWeek: String?
    var flags: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        title = name
        officialNameLabel.text = officialName
        capitalLabel.text = capital
        StartOfTheWeekLabel.text = startOfWeek
        continentsLabel.text = continents?[0]
        timezonelabel.text = timezones?[0]
        populutionLabel.text = String(population ?? 0)
        
        getFlag()
        
    }
    
    @IBOutlet var flagImageView: UIImageView!
    
    @IBOutlet var officialNameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var continentsLabel: UILabel!
    @IBOutlet var populutionLabel: UILabel!
    @IBOutlet var timezonelabel: UILabel!
    @IBOutlet var StartOfTheWeekLabel: UILabel!
    
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMap" {
            if let destinationVC = segue.destination as?  MapViewController {
                destinationVC.latitude = latlong?[0]
                destinationVC.longtude = latlong?[1]
            }
            
        }
    }
    
    // MARK: -  Using Kingfisher to get the flag picture
    func getFlag() {
        let url = URL(string: flags ?? "https://example.com/high_resolution_image.png")
        let processor = DownsamplingImageProcessor(size: flagImageView.bounds.size)
        flagImageView.kf.indicatorType = .activity
        flagImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}
