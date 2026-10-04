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

struct PlannerView: View {
    var body: some View {
        NavigationStack {
            Group {
                if #available(iOS 27.1, *) {
                    FoldAwarePlanner()
                } else {
                    CombinedPlanner()
                }
            }
            .navigationTitle("Planner")
        }
    }
}

@available(iOS 27.1, *)
private struct FoldAwarePlanner: View {
    var body: some View {
        GeometryReader { proxy in
            if proxy.reservedRegions(kind: .division, options: .includeInactive).isEmpty {
                CombinedPlanner()
            } else {
                ArrangementView {
                    List {
                        WeekSection()
                    }
                } secondary: {
                    List {
                        ShoppingSection()
                    }
                }

            }
        }
    }
}

private struct CombinedPlanner: View {
    var body: some View {
        List {
            WeekSection()
            ShoppingSection()
        }
    }
}

private struct WeekSection: View {
    private let week = [
        ("Monday", "Margherita Pizza"),
        ("Tuesday", "Pad Thai"),
        ("Wednesday", "Chicken Tikka Masala"),
        ("Thursday", "Beef Tacos"),
        ("Friday", "Miso Soup"),
        ("Saturday", "Paella"),
        ("Sunday", "Pho")
    ]

    var body: some View {
        Section("This Week") {
            ForEach(week, id: \.0) { day, meal in
                LabeledContent(day, value: meal)
            }
        }
    }
}

private struct ShoppingSection: View {
    private let items = [
        "Tomatoes", "Basil", "Mozzarella", "Rice noodles", "Limes",
        "Chicken thighs", "Tortillas", "Miso paste", "Saffron", "Star anise"
    ]

    var body: some View {
        Section("Shopping List") {
            ForEach(items, id: \.self) { item in
                Label(item, systemImage: "circle")
            }
        }
    }
}

#Preview {
    PlannerView()
}
