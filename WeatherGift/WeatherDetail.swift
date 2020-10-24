//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Manogya Acharya on 10/10/20.
//

import Foundation

class WeatherDetail:WeatherLocation {
    struct Result: Codable {
        var timezone: String
        var current: Current
    }
    struct Current: Codable{
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    struct Weather: Codable{
        var description: String
        var icon: String
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the URL: \(urlString)")
        
        //create a URL
        guard let url = URL(string: urlString) else {
            print("ERROR! Couldn't get data from the URL!")
            completed()
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
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = self.fileNameForIcon(icon: result.current.weather[0].icon)
                print("\(result)")
                print("Timezone for \(self.name) is \(result.timezone)")
            }
            catch{
                print("ERROR: JSON \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
    private func fileNameForIcon(icon: String) -> String {
        var newFileName = ""
        switch icon {
        case "01d":
            newFileName = "clear-day"
        case "01n":
            newFileName = "clear-night"
        case "02d":
            newFileName = "partly-cloudy"
        case "02n":
            newFileName = "partly-cloudy-night"
        case "03d", "03n", "04d", "04n":
            newFileName = "cloudy"
        case "09d", "09n", "10d", "10n":
            newFileName = "clear-day"
        case "11d", "11n":
            newFileName = "lightning"
        case "13d", "13n":
            newFileName = "snow"
        case "50d","50n":
            newFileName = "fog"
        default:
            newFileName = ""
        }
        return newFileName
    }
}
