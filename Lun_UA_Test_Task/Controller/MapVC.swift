//
//  MapVC.swift
//  Lun_UA_Test_Task
//
//  Created by Yura Velko on 2/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {
    
    var person: Person!
    
    let mapView = GMSMapView()
    
    let backArrow: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let returnToPointButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(mapButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleReturn), for: .touchUpInside)
        return button
    }()
    
    @objc func handleReturn() {
        self.setupCamera(zoom: self.defaultZoom)
    }
    
    var defaultZoom = 15.0 as Float
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(mapView)
        view.addSubview(backArrow)
        view.addSubview(returnToPointButton)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        backArrow.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        returnToPointButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 30, paddingRight: 20, width: 0, height: 0)
        
        setupCamera(zoom: defaultZoom)
    }
    
    func setupCamera(zoom: Float) {
        guard let latitude = Double(person.lat) else { return }
        guard let longitude = Double(person.lng) else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: defaultZoom)
        
        mapView.camera = camera
        showMarker(position: camera.target)
    }
    
    func showMarker(position: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = position
        marker.title = person?.address
        guard let name = person?.name else { return }
        guard let phone = person?.phone else { return }
        marker.snippet = "\(nameTitle)\(name)\n\(phoneTitle): \(phone)"
        marker.map = mapView
    }
}

extension MapVC: GMSMapViewDelegate{
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 225, height: 90))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 7
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.font = UIFont.systemFont(ofSize: 16, weight: .light)
        view.addSubview(lbl2)
        
        return view
    }
}
