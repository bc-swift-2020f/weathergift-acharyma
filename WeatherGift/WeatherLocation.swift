//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Manogya Acharya on 10/10/20.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the URL: \(urlString)")
        
        //create a URL
        guard let url = URL(string: urlString) else {
            print("ERROR! Couldn't get data from the URL!")
            return
        }
        
        //create session
        let session = URLSession.shared
        
            //get data with .dataTas
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            }
            catch{
                print("ERROR: JSON \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
}
