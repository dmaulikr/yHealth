import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    var updatingLocation = false
    @IBOutlet weak var _mapView: MKMapView!
    var locations = [Place]()
    var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authStatus : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocation {
            stopLocationManager()
        } else {
            startLocationManager()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    @nonobjc func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let lastLocation = locations.last as! CLLocation
        if (currentLocation == nil) {
            randomLocation(lastLocation)
        }
        currentLocation = lastLocation
        
        let accuracy:CLLocationAccuracy = lastLocation.horizontalAccuracy
        if(accuracy < 100.0) {
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.14 / 10, 0.14 / 10);
            let region:MKCoordinateRegion = MKCoordinateRegionMake(lastLocation.coordinate,span)
            self._mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self._mapView.showsUserLocation = true
    }
    
    func randomLocation(_ location:CLLocation) {
            var newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
            var place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. B Walters", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
            locations.append(place)
        
        
                newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr.Jack Mehoff", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)

        
        
        newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
         place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. Debois - Optometry", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
        
        newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. Rufus - OBGYN", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
        
         newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. Jennifer Slutsky - Optometry", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
        
        
         newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. OMG", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
        
    newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. B Walters", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
        
    newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
         place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. Wang - OBGYN", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
        
         newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. Tom Robsky", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        
        
         newLocation = CLLocation(latitude: location.coordinate.latitude + 0.005 * Double.random(min: -1.0, 1.0) , longitude: location.coordinate.longitude + 0.005 * Double.random(min: -1.0, 1.0))
        place = Place(_location: newLocation, _reference: "_reference", _placeName: "Dr. Kill More", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
        locations.append(place)
        
        showLocations()
    }
    
    @IBAction func addLoctionAction() {
        if (currentLocation != nil) {
            let place = Place(_location: currentLocation!, _reference: "_reference", _placeName: "bleeh bleeh, nwew place", _address: "_address", _phoneNumber: "_phoneNumber", _website: "_website")
            locations.append(place)
        }
        showLocations()
    }
    
    func showLocations() {
        _mapView.addAnnotations(locations)
    }
    
    @IBAction func cameraAction () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let flipsideViewController = storyBoard.instantiateViewController(withIdentifier: "Camera") as! CameraViewController
        flipsideViewController.locations = locations
        flipsideViewController.userLocation = _mapView.userLocation
        self.present(flipsideViewController, animated:true, completion:nil)
    }
}

