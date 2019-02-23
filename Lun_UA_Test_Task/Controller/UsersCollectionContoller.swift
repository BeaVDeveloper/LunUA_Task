//
//  ViewController.swift
//  Lun_UA_Test_Task
//
//  Created by Yura Velko on 2/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

class UsersCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "myCell"
    
    var personArray = [Person]()
    let maxItems = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.register(PersonCell.self, forCellWithReuseIdentifier: cellId)
        
        toJSON()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PersonCell
        cell.person = personArray[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = width + 160
        return CGSize(width: width, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = personArray[indexPath.item]
        let mapVC = MapVC()
        mapVC.person = person
        present(mapVC, animated: true, completion: nil)
    }
    
    
    func toJSON() {
        guard let jsonPayload = jsonString.data(using: .nonLossyASCII, allowLossyConversion: false) else { return }
        
        
        do {
            let json = try JSONSerialization.jsonObject(with: jsonPayload, options: [JSONSerialization.ReadingOptions.mutableContainers]) as? [String: Any]
            
            let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
            
            dispatchQueue.async {
                self.createArray(json, from: 0, to: self.maxItems)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func createArray(_ json: [String: Any]?, from: Int, to: Int) {
        guard let dictionary = json else { return }
        
        if let person = dictionary["person"] as? [String: Any] {
            guard let images = dictionary["images"] as? [[String : Any]] else { return }
            let imageUrl1 = images[0]["link"] as! String
            let imageUrl2 = images[1]["link"] as! String
            
            for _ in from..<to {
                let person = Person(name: person["name"] as! String, address: person["address"] as! String, lat: person["lat"] as! String, lng: person["lng"] as! String, imageUrls: [imageUrl1, imageUrl2], phone: person["phone"] as! String)
                
                personArray.append(person)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}


