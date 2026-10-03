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

struct StartTab: View {
    @State private var store = RecipeStore()

    var body: some View {
        TabView {
            Tab("Recipes", systemImage: "fork.knife") {
                RecipeListView()
            }
            Tab("Discover", systemImage: "sparkles") {
                PlaceholderView(title: "Discover", systemImage: "sparkles", message: "Recommended recipes will appear here.")
            }
            Tab("Planner", systemImage: "calendar") {
                PlannerView()
            }
            Tab("Shopping", systemImage: "cart") {
                PlaceholderView(title: "Shopping", systemImage: "cart", message: "Your shopping list is empty.")
            }
            Tab("Settings", systemImage: "gearshape") {
                PlaceholderView(title: "Settings", systemImage: "gearshape", message: "App settings will appear here.")
            }
        }
        .environment(store)
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    StartTab()
}
