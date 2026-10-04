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

/// Used for both adding (recipe == nil) and editing.
struct RecipeFormView: View {
    @Environment(RecipeStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    private let existing: Recipe?
    @State private var name: String
    @State private var cuisine: String
    @State private var minutes: Int
    @State private var notes: String

    init(recipe: Recipe? = nil) {
        existing = recipe
        _name = State(initialValue: recipe?.name ?? "")
        _cuisine = State(initialValue: recipe?.cuisine ?? "")
        _minutes = State(initialValue: recipe?.minutes ?? 30)
        _notes = State(initialValue: recipe?.notes ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Cuisine", text: $cuisine)
                Stepper("Time: \(minutes) min", value: $minutes, in: 5...480, step: 5)
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle(existing == nil ? "New Recipe" : "Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
        .verticalToolbarDisabled()
    }

    private func save() {
        if var recipe = existing {
            recipe.name = name
            recipe.cuisine = cuisine
            recipe.minutes = minutes
            recipe.notes = notes
            store.update(recipe)
        } else {
            store.add(Recipe(name: name, cuisine: cuisine, minutes: minutes, notes: notes))
        }
        dismiss()
    }
}

extension View {
    @ViewBuilder
    func verticalToolbarDisabled() -> some View {
        if #available(iOS 27.1, *) {
            toolbarVerticalBehavior(.disabled)
        } else {
            self
        }
    }
}
