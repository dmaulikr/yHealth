import UIKit
import MapKit
import Alamofire

class CameraViewController: UIViewController, ARLocationDelegate, ARDelegate, ARMarkerDelegate, MarkerViewDelegate {
    
    
    var userLocation:MKUserLocation?
    var locations = [Place]()
    var geoLocationsArray = [ARGeoCoordinate]()
    var _arController:AugmentedRealityController!
    
    var sympton: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (_arController == nil) {
            _arController = AugmentedRealityController(view: self.view, parentViewController: self, withDelgate: self)
            
            _arController!.minimumScaleFactor = 0.5
            _arController!.scaleViewsBasedOnDistance = true
            _arController!.rotateViewsBasedOnPerspective = true
            _arController!.debugMode = false
        }
        geoLocations()
        
        Alamofire.request("http://geia-api.herokuapp.com/geia/api/v1.0/ip").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateGeoLocations() {
        for place in locations {
            let coordinate:ARGeoCoordinate = ARGeoCoordinate(location: place.location, locationTitle: place.placeName)
            coordinate.calibrate(usingOrigin: userLocation?.location)
            
            let markerView:MarkerView = MarkerView(_coordinate: coordinate, _delegate: self)
            coordinate.displayView = markerView
            
            _arController?.addCoordinate(coordinate)
            geoLocationsArray.append(coordinate)
        }
        
    }
    
    func locationClicked(_ coordinate:ARGeoCoordinate) {
        
    }
    
    func geoLocations() -> NSMutableArray{
        
        if(geoLocationsArray.count == 0) {
            generateGeoLocations()
        }
        return NSMutableArray(array: geoLocationsArray) ;
        
    }
    
    func locationClicked() {
    }
    
    func didUpdate(_ newHeading:CLHeading){
        
    }
    func didUpdate(_ newLocation:CLLocation){
        
    }
    func didUpdate(_ orientation:UIDeviceOrientation) {
        
    }
    
    func didTapMarker(_ coordinate:ARGeoCoordinate) {
        
    }
    
    func didTouchMarkerView(_ markerView:MarkerView) {
        
    }
    
    @IBAction func doneAction() {
        dismiss(animated: true, completion: nil)
    }
    
}
