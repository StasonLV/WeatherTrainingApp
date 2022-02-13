//
//  ViewController.swift
//  WeatherTraining App
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var temperatureF: UILabel!
    @IBOutlet weak var countryLable: UILabel!
    @IBOutlet weak var feelsCLabel: UILabel!
    @IBOutlet weak var feelsFLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        
    }
    


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let urlString = URL(string: "https://api.weatherapi.com/v1/current.json?key=b98b6c141da24b30a57152921221302&q=\(citySearchBar.text!)&aqi=no")
        
        var locationName: String?
        var temperatureC: Double?
        var tempertaureF: Double?
        var countryName: String?
        var feelsLikeC: Double?
        var feelsLikeF: Double?
        
        let task = URLSession.shared.dataTask(with: urlString!) {[weak self] (data, response, error) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let location = json ["location"] {
                    locationName = location ["name"] as? String
                }
                
                if let current = json ["current"] {
                    temperatureC = current ["temp_c"] as? Double
                }
                
                if let current = json ["current"] {
                    feelsLikeC = current ["feelslike_c"] as? Double
                }
                
                if let current = json ["current"] {
                    tempertaureF = current ["temp_f"] as? Double
                }
                
                if let current = json ["current"] {
                    feelsLikeF = current ["temp_f"] as? Double
                }
                
                if let location = json ["location"] {
                    countryName = location ["country"] as? String
                }
                
                DispatchQueue.main.async {
                    self?.cityName.text = locationName
                    self?.temperature.text = "\(String(describing: temperatureC!)) in C"
                    self?.feelsCLabel.text = "feels like \(String(describing: feelsLikeC!))"
                    self?.temperatureF.text = "\(String(describing: tempertaureF!)) in Fh"
                    self?.feelsFLabel.text = "feels like \(String(describing: feelsLikeF!))"
                    self?.countryLable.text = countryName
                }
                
                
            }
            catch let jsonError {
                print(jsonError)
            }
        }
                
        task.resume()
    }
}
