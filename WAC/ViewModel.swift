//
//  ViewModel.swift
//  WAC
//
//  Created by Irine on 07/11/23.
//

import Foundation
import SwiftUI

struct MainData: Hashable,Codable {
    let type: String?
    let data: [Category]?
    
    enum codingKeys: String, CodingKey {
            case data
        }
}
struct Category: Hashable, Codable {
    let id: String?
    let image: String?
    let name:String?
}
struct BannerData: Hashable,Codable {
    let type: String?
    let data: [Banner]?
    
    enum codingKeys: String, CodingKey {
            case data
        }
}
struct Banner: Hashable, Codable {
    let id: String?
    let image: String?
}


class ViewModel: ObservableObject {
    @Published var mainData: [MainData] = []
    @Published var category : [Category] = []
    
    @Published var banner : [ Category] = []
    
    func fetch () {
        guard let url = URL (string: "https://run.mocky.io/v3/17db81c4-f48e-408a-bf06-c289ee825e06") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _,error in
            
            do {
                let mainData = try JSONDecoder().decode( [MainData].self, from: data!)
                
                DispatchQueue.main.async {
                    self.category = mainData[0].data!
                    self.banner = mainData[1].data!
                    print(self.banner)
                }
            }
            catch {
                print (error)
            }
        }
        task.resume()
    }
}
