//
//  MapViewController.swift
//  Countries
//
//  Created by Mohamed Mostafa on 05/12/2021.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var latitude: Double?
    var longtude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        navigationController?.navigationBar.backgroundColor = .systemYellow
        mapView.centerCoordinate.latitude = latitude ?? 51.507222
        mapView.centerCoordinate.longitude = longtude ?? -0.1275
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
