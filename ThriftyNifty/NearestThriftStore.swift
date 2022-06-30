//
//  NearestThriftStore.swift
//  ThriftyNifty
//
//  Created by Roumiana Mihaylova on 6/29/22.
//

import CoreLocation
import MapKit
import UIKit

class NearestThriftStore: UIViewController {

    
    @IBOutlet var mapView: MKMapView!
    
    
    @IBAction func tBackBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
        } else {
            mapView.mapType = .satellite
        }
    }
    
    
    
    let locationManager = CLLocationManager()
        let regionInMeters: Double = 6100
        
        override func viewDidLoad() {
            super.viewDidLoad()
            checkLocationServices()
            
            let annotation1 = MKPointAnnotation()
            annotation1.coordinate = CLLocationCoordinate2D(latitude: 40.7306907, longitude: -73.985738)
            annotation1.title = "East Village Thrift Shop"
            annotation1.subtitle = "Thrift Store"
            mapView.addAnnotation(annotation1)
            
            
            let annotation2 = MKPointAnnotation()
            annotation2.coordinate = CLLocationCoordinate2D(latitude: 40.7392145, longitude: -73.983581)
            annotation2.title = "Housing Works Thrift Shops - Gramercy"
            annotation2.subtitle = "Thrift Store"
            mapView.addAnnotation(annotation2)
            
            
            let annotation3 = MKPointAnnotation()
            annotation3.coordinate = CLLocationCoordinate2D(latitude: 40.74868392944336, longitude: -74.00062561035156)
            annotation3.title = "City Opera Thrift Shop"
            annotation3.subtitle = "Thrift Store"
            mapView.addAnnotation(annotation3)
            
            
            let annotation4 = MKPointAnnotation()
            annotation4.coordinate = CLLocationCoordinate2D(latitude: 40.736116, longitude: -74.005060)
            annotation4.title = "Rothy's"
            annotation4.subtitle = "Sustainable Fashion"
            mapView.addAnnotation(annotation4)

        }
        
        
        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapView.setRegion(region, animated: true)
            }
        }
        
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
                // Show alert letting the user know they have to turn this on.
            }
        }
        
        
        func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                // Show alert instructing them how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Show an alert letting them know what's up
                break
            case .authorizedAlways:
                break
            }
        }
    }


    extension NearestThriftStore: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        
        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
    }
