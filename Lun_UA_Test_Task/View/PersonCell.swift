//
//  PersonCell.swift
//  Lun_UA_Test_Task
//
//  Created by Yura Velko on 2/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    var person: Person? {
        didSet {
            
            setupAttributedInfo()
            guard let imageUrl = person?.imageUrls[0] else { return }
            photoImageView.loadImage(urlString: imageUrl)
        }
    }
    
    private func setupAttributedInfo() {
        guard let person = person else { return }
        
        let nameAttributedText = NSMutableAttributedString(string: nameTitle, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        nameAttributedText.append(NSAttributedString(string: person.name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        
        
        let phoneAttributedText = NSMutableAttributedString(string: phoneTitle, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        phoneAttributedText.append(NSAttributedString(string:" \(person.phone)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        
        nameLabel.attributedText = nameAttributedText
        phoneLabel.attributedText = phoneAttributedText
    }
    
    let photoImageView = CustomImageView(frame: .zero)
    
    lazy var switchToRight: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "right_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleNext() {
        
        if person?.photoIndex == 0 {
            person?.photoIndex = 1
        } else if person?.photoIndex == 1 {
            person?.photoIndex = 0
        }
        if person?.photoIndex != nil {
            guard let imageUrl = person?.imageUrls[(person?.photoIndex)!] else { return }
            photoImageView.loadImage(urlString: imageUrl)
        }
    }
    
    lazy var switchToLeft: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "left_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    let nameLabel = UILabel()
    let phoneLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        let nameView = UIView()
        let phoneView = UIView()
        phoneView.backgroundColor = .gray
        nameView.backgroundColor = .gray
        
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(phoneLabel)
        addSubview(switchToRight)
        addSubview(switchToLeft)
        addSubview(nameView)
        addSubview(phoneView)
        photoImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        nameLabel.anchor(top: photoImageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        nameView.anchor(top: nameLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0.5)
        
        phoneLabel.anchor(top: nameView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        phoneView.anchor(top: phoneLabel.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0.5)
        
        switchToRight.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        switchToRight.anchor(top: nil, left: nil, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        switchToLeft.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        switchToLeft.anchor(top: nil, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
