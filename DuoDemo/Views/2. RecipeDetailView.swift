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

import SwiftUI

struct RecipeDetailView: View {
    @Environment(RecipeStore.self) private var store
    let recipe: Recipe
    @State private var editing = false

    /// Always show the latest version held by the store.
    private var current: Recipe {
        store.recipes.first { $0.id == recipe.id } ?? recipe
    }

    var body: some View {
        List {
            Section {
                LabeledContent("Cuisine", value: current.cuisine)
                LabeledContent("Time", value: "\(current.minutes) min")
                LabeledContent("Favorite", value: current.isFavorite ? "Yes" : "No")
            }
            Section("Notes") {
                Text(current.notes.isEmpty ? "No notes" : current.notes)
            }
        }
        .navigationTitle(current.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") { editing = true }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Favorite", systemImage: current.isFavorite ? "heart.fill" : "heart") {
                    store.toggleFavorite(current)
                }
            }
        }
        .sheet(isPresented: $editing) {
            RecipeFormView(recipe: current)
        }
    }
}
