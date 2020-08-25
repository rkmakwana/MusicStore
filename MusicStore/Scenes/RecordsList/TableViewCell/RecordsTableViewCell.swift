//
//  RecordsTableViewCell.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

protocol RecordsCellView {
    func configure(with record: Record)
}

class RecordsTableViewCell: UITableViewCell, RecordsCellView {
    
    private let dateFormatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(artworkImageView)
        self.contentView.addSubview(trackNameLabel)
        self.contentView.addSubview(collectionNameLabel)
        self.contentView.addSubview(selectionImageView)
        self.contentView.addSubview(artistNameLabel)
        self.contentView.addSubview(releasedOnLabel)
        self.contentView.addSubview(trackPriceLabel)
        
        artworkImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        artworkImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:20).isActive = true
        artworkImageView.widthAnchor.constraint(equalToConstant:60.0).isActive = true
        let height = artworkImageView.heightAnchor.constraint(equalToConstant:60.0)
        height.priority = UILayoutPriority(999)
        height.isActive = true
        
        trackPriceLabel.topAnchor.constraint(equalTo: artworkImageView.bottomAnchor, constant: 8).isActive = true
        trackPriceLabel.centerXAnchor.constraint(equalTo: artworkImageView.centerXAnchor).isActive = true
        trackPriceLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -14).isActive = true
        
        trackNameLabel.topAnchor.constraint(equalTo: artworkImageView.topAnchor).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo:artworkImageView.trailingAnchor, constant:20).isActive = true
        trackNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 5).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo:trackNameLabel.leadingAnchor).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
        collectionNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8).isActive = true
        collectionNameLabel.leadingAnchor.constraint(equalTo:artistNameLabel.leadingAnchor).isActive = true
        
        selectionImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        selectionImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        selectionImageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        selectionImageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        selectionImageView.leadingAnchor.constraint(equalTo: collectionNameLabel.trailingAnchor, constant: 5).isActive = true
        
        
        releasedOnLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 8).isActive = true
        releasedOnLabel.leadingAnchor.constraint(equalTo:collectionNameLabel.leadingAnchor).isActive = true
        releasedOnLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -14).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let artworkImageView: CachedImageView = {
        let img = CachedImageView()
        img.backgroundColor = .systemPink
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        img.layer.borderWidth = 2.5
        img.layer.borderColor = UIColor.systemPink.cgColor
        return img
    }()
    
    let selectionImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let trackPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor =  .label
        } else {
            label.textColor =  .black
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        if #available(iOS 13.0, *) {
            label.textColor =  .secondaryLabel
        } else {
            label.textColor =  .darkGray
        }
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releasedOnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with record: Record) {
        trackNameLabel.text = record.trackName
        trackPriceLabel.text = String(format: "$%.2f", record.collectionPrice)
        collectionNameLabel.text = record.collectionName ?? "No collection"
        artistNameLabel.text = "By: \(record.artistName)"
        
        let releaseDate = formattedDate(date: record.releaseDate)
        releasedOnLabel.text = "Released on: \(releaseDate)"
        
        let imageName = (record.selected == true) ? ImageNames.selectedCheckMark : ImageNames.unselectedCheckMark
        selectionImageView.image = UIImage(named: imageName)
        
        
        artworkImageView.image = nil
        artworkImageView.backgroundColor = .systemPink
        if let imgUrl = record.artworkUrl100 {
            artworkImageView.setImage(url: imgUrl) { success in
                if success {
                    self.artworkImageView.backgroundColor = .clear
                }
            }
        }
    }
    
    private func formattedDate(date: Date) -> String {
        dateFormatter.dateFormat = AppConstants.defaultDateFormat
        return dateFormatter.string(from: date)
    }
}
