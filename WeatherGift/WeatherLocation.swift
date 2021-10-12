//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by John Mekus on 10/4/21.
//

import Foundation

class WeatherLocation: Codable
{
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double)
    {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData()
    {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=-\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the url \(urlString)")
        
        //create a URL
        guard let url = URL(string: urlString) else
        {
            print("ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        //create session
        let session = URLSession.shared
        
        //get data with .datatask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error
            {
                print("ERROR: \(error.localizedDescription)")
            }
            
            //NOTE: other things could be going wrong with URLs but we are ignoring those for right now...
            
            //deal with the data
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch
            {
                print("JSON ERROR: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
