//
//  DetailViewController.swift
//  Amadeus
//
//  Created by Mimosa David on 2/23/23.
//  Weather detail screen for particular selected city

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var latlonLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var model : WeatherModel = WeatherModel()

    // MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //render UI showing data of a particular city
        self.renderCityData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // MARK: Render UI
    
    /// Description: Render UI from Model.
    /// Shows data of a particular city.
    /// - Parameter value: none
    /// - Returns: none
    func renderCityData() {
        self.cityLabel.text = model.city
        self.countryLabel.text = model.country
        self.tempLabel.text = model.temp
        self.latlonLabel.text = model.latlon
        
        
        //show appropriate weather icon accoring to weather type
        var icon = ""
        if let weatherText = model.weather?.lowercased() {
            
            if weatherText.contains("cloud") {
                icon = "clouds"
            }else if weatherText.contains("rain") {
                icon = "rain"
            }else if weatherText.contains("mist") {
                icon = "mist"
            }else if weatherText.contains("sand") {
                icon = "sand"
            }else {
                icon = "clear"
            }
            let image : UIImage = UIImage(named:icon)!
            self.weatherImageView.image = image
        }
        
    }
}
