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

struct RecipeListView: View {
    @Environment(RecipeStore.self) private var store
    @State private var searchText = ""
    @State private var showingAdd = false
    @State private var recipeToEdit: Recipe?

    private var filtered: [Recipe] {
        guard !searchText.isEmpty else { return store.recipes }
        return store.recipes.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.cuisine.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filtered) { recipe in
                NavigationLink(value: recipe) {
                    RecipeRow(recipe: recipe)
                }
                // Leading edge
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button("Favorite", systemImage: "heart") {
                        store.toggleFavorite(recipe)
                    }
                    .tint(.pink)
                    Button("Pin", systemImage: "pin") {
                        print("Pin \(recipe.name)")
                    }
                    .tint(.orange)
                }
                // Trailing edge
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        store.delete(recipe)
                    }
                    Button("Edit", systemImage: "pencil") {
                        recipeToEdit = recipe
                    }
                    .tint(.blue)
                    Button("Share", systemImage: "square.and.arrow.up") {
                        print("Share \(recipe.name)")
                    }
                    .tint(.green)
                }
            }
            .navigationTitle("Recipes")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .searchable(text: $searchText, prompt: "Search recipes")
            .overlay {
                if filtered.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sort", systemImage: "arrow.up.arrow.down") { print("Sort") }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Filter", systemImage: "line.3.horizontal.decrease") { print("Filter") }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Share", systemImage: "square.and.arrow.up") { print("Share list") }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { showingAdd = true }
                }
            }
            .sheet(isPresented: $showingAdd) {
                RecipeFormView()
            }
            .sheet(item: $recipeToEdit) { recipe in
                RecipeFormView(recipe: recipe)
            }
        }
    }
}

#Preview {
    RecipeListView()
        .environment(RecipeStore())
}
