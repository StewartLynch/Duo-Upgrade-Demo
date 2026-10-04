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

struct SettingView: View {
    var body: some View {
        NavigationStack {
            if #available(iOS 27.1, *) {
                DuoLabView()
            } else {
                ContentUnavailableView("Settings", systemImage: "gearshape", description: Text("App settings will appear here."))
                    .navigationTitle("Settings")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("More", systemImage: "ellipsis.circle") { print("Settings more") }
                        }
                    }
            }
        }
    
    }
}

#Preview {
    SettingView()
}
