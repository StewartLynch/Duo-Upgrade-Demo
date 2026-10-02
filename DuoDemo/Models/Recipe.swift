//
//----------------------------------------------
// Original project: DuoDemo
//
// Follow me on Mastodon: https://iosdev.space/@StewartLynch
// Follow me on Threads: https://www.threads.net/@stewartlynch
// Follow me on Bluesky: https://bsky.app/profile/stewartlynch.bsky.social
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Email: slynch@createchsol.com
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2026 CreaTECH Solutions (Stewart Lynch). All rights reserved.

import Foundation

struct Recipe: Identifiable, Hashable {
    let id: UUID
    var name: String
    var cuisine: String
    var minutes: Int
    var notes: String
    var isFavorite: Bool

    init(id: UUID = UUID(), name: String, cuisine: String, minutes: Int, notes: String = "", isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.cuisine = cuisine
        self.minutes = minutes
        self.notes = notes
        self.isFavorite = isFavorite
    }
}

extension Recipe {
    static let samples: [Recipe] = [
        Recipe(name: "Slow-Roasted Lamb Shoulder with Rosemary and Garlic", cuisine: "British", minutes: 240, notes: "Rub the shoulder with garlic and rosemary, then roast it low and slow until it falls off the bone. Rest it for twenty minutes before serving."),
        Recipe(name: "Thai Green Curry with Jasmine Rice and Fresh Basil", cuisine: "Thai", minutes: 40, notes: "Fry the paste first so the oils release their fragrance, then add the coconut milk and finish with plenty of Thai basil and a squeeze of lime."),
        Recipe(name: "Spaghetti alla Carbonara with Guanciale and Pecorino", cuisine: "Italian", minutes: 25, notes: "Take the pan off the heat before adding the egg and cheese, and use a splash of the pasta water to make the sauce glossy instead of scrambled."),
        Recipe(name: "Margherita Pizza", cuisine: "Italian", minutes: 45, notes: "Fresh basil, buffalo mozzarella and a very hot oven.", isFavorite: true),
        Recipe(name: "Pad Thai", cuisine: "Thai", minutes: 30, notes: "Tamarind paste is the secret. Don't skip the lime."),
        Recipe(name: "Chicken Tikka Masala", cuisine: "Indian", minutes: 60, notes: "Marinate the chicken overnight if you can."),
        Recipe(name: "Beef Tacos", cuisine: "Mexican", minutes: 25, notes: "Warm the tortillas directly over the flame.", isFavorite: true),
        Recipe(name: "Miso Soup", cuisine: "Japanese", minutes: 15, notes: "Never boil the miso."),
        Recipe(name: "Ratatouille", cuisine: "French", minutes: 75, notes: "Slice the vegetables thin and even."),
        Recipe(name: "Greek Salad", cuisine: "Greek", minutes: 10, notes: "Good feta makes all the difference."),
        Recipe(name: "Butter Chicken", cuisine: "Indian", minutes: 50, notes: "Finish with a swirl of cream."),
        Recipe(name: "Sushi Rolls", cuisine: "Japanese", minutes: 90, notes: "Seasoned rice should be just warm."),
        Recipe(name: "Shakshuka", cuisine: "Middle Eastern", minutes: 30, notes: "Serve with crusty bread.", isFavorite: true),
        Recipe(name: "Paella", cuisine: "Spanish", minutes: 70, notes: "Aim for the crispy socarrat at the bottom."),
        Recipe(name: "Pho", cuisine: "Vietnamese", minutes: 180, notes: "Char the onion and ginger first.")
    ]
}