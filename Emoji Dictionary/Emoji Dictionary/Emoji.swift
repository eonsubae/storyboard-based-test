//
//  Emoji.swift
//  Emoji Dictionary
//
//  Created by ma-esb on 2020/12/21.
//

import Foundation

struct Emoji {
    var character = ""
    var definition = ""
    var year = 0
    var rating = 0.0
    var category = ""
}

let emojis = ["🚗", "⛪️", "🙃", "🥖", "🚑"]


func getEmojis() -> [Emoji] {
    let emoji1 = Emoji(character: "🚗", definition: "Racecar", year: 2013, rating: 4.1, category: "Vehicles")
    let emoji2 = Emoji(character: "⛪️", definition: "Church", year: 2010, rating: 3.8, category: "Buildings")
    let emoji3 = Emoji(character: "🙃", definition: "Upsidedown Smilely", year: 2017, rating: 3.7, category: "Faces")
    let emoji4 = Emoji(character: "🥖", definition: "Burrito", year: 2020, rating: 2.8, category: "Food")
    let emoji5 = Emoji(character: "🚑", definition: "Ambulance", year: 2018, rating: 3.5, category: "Vehicles")

    return [emoji1, emoji2, emoji3, emoji4, emoji5]
}
