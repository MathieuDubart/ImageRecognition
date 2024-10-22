//
//  NetworkManager.swift
//  test_compilation
//
//  Created by Mathis Viollet on 22/10/2024.
//

import SwiftUI

class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var downloadedStringValue: String = ""
    
    @Published var downloadedImageValue: UIImage = UIImage()
    
    func downloadString(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print(response ?? "No text response")
                    return
                }
                if let mimeType = httpResponse.mimeType, mimeType == "text/html",
                   let data = data,
                   let string = String(data: data, encoding: .utf8) {
                    
                    DispatchQueue.main.async {
                        self.downloadedStringValue = string
                    }
                }
            }
            task.resume()
        } else {
            print("url daubé")
        }
    }
    
    func downloadImage(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print(response ?? "No image response")
                    return
                }
                if let mimeType = httpResponse.mimeType, mimeType == "image/png" ||  mimeType == "image/jpeg",
                   let data = data,
                   let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.downloadedImageValue = image
                    }
                }
            }
            task.resume()
        } else {
            print("url daubé")
        }
    }
}
