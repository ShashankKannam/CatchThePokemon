//
//  ViewController.swift
//  CatchThePokemon
//
//  Created by shashank kannam on 1/14/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var geoFire:GeoFire!
    var geoFireRef: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        geoFireRef = FIRDatabase.database().reference()
        
        geoFire = GeoFire(firebaseRef: geoFireRef)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthorStatus()
    }
    
    func locationAuthorStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }else{
          locationManager.requestWhenInUseAuthorization()
        }
    }

    func centreMapOnLocation(location: CLLocation){
        let coordinate = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinate, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView:MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self){
          annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "ash")
        }
        return annotationView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getPokemons(_ sender: UIButton) {
        
    }

}

