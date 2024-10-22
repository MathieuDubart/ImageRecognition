//
//  ContentView.swift
//  ImageRecognition
//
//  Created by digital on 22/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var urlToFetch: String = ""
    @State private var image: UIImage?
    @State private var imageDescription: String = ""
    
    @ObservedObject var networkManager = NetworkManager.shared
    @StateObject var imageRecognitionManager = ImageRecognitionManager()
    var body: some View {
        VStack {
            
            if let img = self.image {
                Image(uiImage: img)
                    .resizable()
                    .frame(height: 300)
                    .scaledToFit()
            }
            
            Spacer()
                .frame(height:20)
            
            TextField("Url to fetch",text:self.$urlToFetch)
                .textFieldStyle(.roundedBorder)
                .padding([.horizontal], 20)
            
            Spacer()
                .frame(height:40)
            
            HStack {
                Button("Download") {
                    networkManager.downloadImage(urlString: urlToFetch);
                    self.urlToFetch = ""
                }
                
                Spacer().frame(width:40)
                
                Button ("Recognize") {
                    if let img = self.image {
                        imageRecognitionManager.recognizeObjectsIn(image: img)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
                .frame(height:40)
            
            Text("\(self.imageDescription)")
                .padding([.horizontal], 20)
        }
        .onChange(of: networkManager.downloadedImageValue) { oldValue, newValue in
            self.image = newValue
        }
        .onChange(of: imageRecognitionManager.imageDescription) { oldValue, newValue in
            self.imageDescription = newValue
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
