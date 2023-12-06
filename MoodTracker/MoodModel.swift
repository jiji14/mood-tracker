//
//  MoodModel.swift
//  MoodTracker
//
//  Created by Jijeong Lee on 12/5/23.
//

import Foundation

struct MoodModel {
    var id: String
    let name: String
    let mood: String
    let rate: Int
    let date: String
    
    init?(_ dictionary: [String: Any]) {
        guard
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let mood = dictionary["mood"] as? String,
            let rate = dictionary["rate"] as? Int,
            let date = dictionary["date"] as? String // Remove the comma here
        else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.mood = mood
        self.rate = rate
        self.date = date
    }
}
