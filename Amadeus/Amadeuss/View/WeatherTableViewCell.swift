//
//  ProductTableViewCell.swift
//  Amadeus
//
//  Created by Mimosa David on 2/21/23.
//  TableViewCell for weather item list in the main screen

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var latlonLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cellBackgroundImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackgroundImgView.layer.cornerRadius = 10
        cellView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
