# DuoDemo

Starter app for a YouTube tutorial: adapt an iPhone-only, portrait-only SwiftUI app to iPad and iPhone Duo.
Parent folder has `Instructions.md`, `Resources.md`, and `Summary.md` (running change log + Duo roadmap — keep updated).

- Architecture: SwiftUI, `@Observable` `RecipeStore` injected via `.environment`; mock data in `Models/Recipe.swift`.
- Files live in a synchronized Xcode group: add files on disk under `DuoDemo/` and they are included.
- Deliberately restrictive settings (do NOT "fix" until tutorial step): iPhone only, portrait only, `NavigationStack`, deployment target 26.5.
- Build: `xcodebuild -project DuoDemo.xcodeproj -scheme DuoDemo -destination 'generic/platform=iOS Simulator' build`
- Gotcha: installed Xcode is 27.0; iPhone Duo APIs (27.1 SDK) need Xcode 27.1.
