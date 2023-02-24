//
//  ViewController.swift
//  Amadeus
//
//  Created by Mimosa David on 2/20/23.
//  Main screen of weather app displaying list of cities with weather info

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let weatherCellId = "WeatherTableViewCell"
    private var weatherItems = [WeatherModel]()
    private var searchedArray = [WeatherModel]()
    private var selectedWeatherItem = WeatherModel()
    private var searching = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customizeSearchBar()
        // Register cell
        tableView.register(UINib.init(nibName: weatherCellId, bundle: nil), forCellReuseIdentifier: weatherCellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        
        //fetch JSON data
        fetchJsonData()
        
        // Refresh the list
        tableView.reloadData()
    }
    
    
    /// Customizes the search bar appearance
    ///
    /// - Parameters: none
    /// - Returns: none
    func customizeSearchBar() {
        // Change the Tint Color
        searchBar.tintColor = UIColor.white
        // Show/Hide Cancel Button
        searchBar.showsCancelButton = true
        // Change TextField Colors
        let searchTextField = searchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.clearButtonMode = .never
        // Change Glass Icon Color
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = .white
        
        
        searchBar.keyboardAppearance = .dark
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCityDetail" {
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.model = selectedWeatherItem
            }
        }
    }
    
    // MARK: Fetch Data
    
    /// Fetches weather data from JSON file in the bundle
    ///
    /// - Parameter value: none
    /// - Returns: none
    func fetchJsonData() {
        let jsonData = WeatherManager.shared.readLocalJSONFile(forName: "weather_test")

        if let safeData = jsonData {
            if let weatherItems = WeatherManager.shared.parse(jsonData: safeData) {
                self.weatherItems = weatherItems
                tableView.reloadData()
            }
        }
    }
}

// MARK: TableView Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedArray.count
        } else {
            return weatherItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherCellId, for: indexPath) as! WeatherTableViewCell
        cell.selectionStyle = .none
        var weatherItem = WeatherModel()
        
        //if search is ON, display searched results
        //else, display all items
        weatherItem = searching ? searchedArray[indexPath.row] : weatherItems[indexPath.row]
        
        //render the UI fields from the model
            cell.cityLabel.text = weatherItem.city
            cell.latlonLabel.text = weatherItem.latlon
            cell.tempLabel.text = weatherItem.temp
            cell.countryLabel.text = weatherItem.country
            cell.weatherLabel.text = weatherItem.weather
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get the selected item
        selectedWeatherItem = searching ? searchedArray[indexPath.row] : weatherItems[indexPath.row]
       
        // Close keyboard after selecting cell
         searchBar.searchTextField.endEditing(true)
        
        //go to detail screen for selected City
        self.performSegue(withIdentifier: "goToCityDetail", sender: nil)
       
    }
}

// MARK: Searchbar Methods
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedArray.removeAll()
        //filter items in the list based on serch text
        searchedArray = weatherItems.filter{$0.city?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
        
        //turn searching ON
        searching = true
        
        //refresh the list
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        //turn searching OFF
        searching = false
        
        //refresh the list to display all data
        searchBar.text = ""
        tableView.reloadData()
    }
}
