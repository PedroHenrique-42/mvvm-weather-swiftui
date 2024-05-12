//
//  ViewModel.swift
//  MVVMWeather
//
//  Created by Pedro Henrique on 14/12/23.
//

import Foundation

// Data need by view

class WeatherViewModel: ObservableObject {
    @Published var title: String = "-"
    @Published var descriptionText: String = "-"
    @Published var temp: String = "-"
    @Published var timezone: String = "-"
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        guard let url = URL(
            string: "https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=40.7128&lon=-74&units=imperial&appid=11d71a616103110d5ad05788ef90814e"
        ) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                return
            }
            
            // Convert data to Model
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.title = model.current.weather.first?.main ?? "No title"
                    self.descriptionText = model.current.weather.first?.description ?? "No description"
                    self.temp = "\(model.current.temp)°"
                    self.timezone = model.timezone
                }
            } catch {
                print("Request failed")
            }
        }
        task.resume()
    }
}
