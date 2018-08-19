//
//  CityCoordinateViewController.swift
//  Cities
//
//  Created by Rafael Nascimento on 18/08/18.
//  Copyright © 2018 Rafael Nascimento. All rights reserved.
//

import UIKit
import MapKit

final class CityAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = title
        super.init()
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class CityCoordinateViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMapView()
        self.setUpNavBar()
    }
    
    private func setUpNavBar() {
        navigationItem.title = "\(city?.name ?? ""), \(city?.country ?? "")"
    }
    
    private func setUpMapView() {
        let coord = CLLocationCoordinate2D(latitude: (city?.coord.lat)!, longitude: (city?.coord.lon)!)
        let annotation = CityAnnotation(coordinate: coord, title: (city?.name)!, subtitle: (city?.country)!)
        mapView.addAnnotation(annotation)
        mapView.setRegion(annotation.region, animated: true)
    }
}
