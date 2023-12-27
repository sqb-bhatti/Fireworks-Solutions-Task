

import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    let panel = FloatingPanelController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Colleges"
        setupUI()
    }
    
    private func setupUI() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        panel.set(contentViewController: searchVC)
        
        panel.addPanel(toParent: self)
    }
}



extension MapViewController: SearchViewControllerDelegate {
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else {
            return
        }
        
        panel.move(to: .tip, animated: true)
        map.removeAnnotations(map.annotations)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        map.addAnnotation(pin)
        
        map.setRegion(MKCoordinateRegion(center: coordinates,
                                         span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)),
                      animated: true)
    }
}
