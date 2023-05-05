//
//  ViewController.swift
//  GPSDemo
//
//  Created by Talor Levy on 2/17/23.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - @IBOutlet
    
    @IBOutlet weak var aMap: MKMapView!
    
    var locationManager: CLLocationManager!
    var viewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationService()
        updateUsers()
    }
    
    func updateUsers() {
        viewModel.fetchUsersData {
            DispatchQueue.main.async { [weak self] in
                let userArray = self?.viewModel.usersArray
                for user in userArray ?? [] {
                    let lat = user.address?.geo?.lat ?? ""
                    let long = user.address?.geo?.lng ?? ""
                    let city = user.address?.city ?? ""
                    self?.dropPin(strLat: lat, strLong: long, city: city)
                }
                let user = userArray?.last
                let lat = Double(user?.address?.geo?.lat ?? "")
                let long = Double(user?.address?.geo?.lng ?? "")
                let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
                let mapCamera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 10000000, pitch: 0, heading: 0)
                self?.aMap.setCamera(mapCamera, animated: true)
            }
        }
    }
    
    func setUpLocationService() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func dropPin(strLat: String, strLong: String, city: String) {
        guard let lat = Double(strLat), let long = Double(strLong) else { return }
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.title = city
        annotation.coordinate = coord
        aMap.addAnnotation(annotation)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

