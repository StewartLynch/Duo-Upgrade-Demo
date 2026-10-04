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

// ----------------------------------------------------------------------------
// iPhone Duo helpers for the DuoDemo tutorial  (file 1 of 2: FoldGuide.swift)
//
// What it is:  `.foldGuide()` draws the iPhone Duo's division region (the fold)
//              over a view: a translucent band for the region's frame and a line
//              at the fold. Solid line = region active, dashed = inactive.
//
// Requires:    Xcode 27.1 / iOS 27.1 SDK. Behind #available, so it does nothing on
//              earlier systems and the deployment target can stay lower.
// Use:         Apply once at the root, for example after `.environment(store)`:
//                  .foldGuide()
//              Switch it on from the Duo Lab (DuoLabView.swift), or launch with the
//              argument  -showFoldGuide YES
// Also used by DuoLabView.swift:  `showFoldGuideKey`.
// ----------------------------------------------------------------------------

import SwiftUI

extension View {
    /// Draws the fold on top of this view when the "Show fold guide" switch (Settings tab) is on.
    /// iOS 27.1+ only; on older systems it does nothing.
    @ViewBuilder
    func foldGuide() -> some View {
        if #available(iOS 27.1, *) {
            modifier(FoldGuideModifier())
        } else {
            self
        }
    }
}

/// UserDefaults key shared by the switch in the Duo Lab and the overlay below.
let showFoldGuideKey = "showFoldGuide"

@available(iOS 27.1, *)
private struct FoldGuideModifier: ViewModifier {
    @AppStorage(showFoldGuideKey) private var showFoldGuide = false

    func body(content: Content) -> some View {
        content.overlay {
            if showFoldGuide {
                GeometryReader { proxy in
                    // Regions are reported in this reader's own coordinate space,
                    // so they can be drawn here without converting anything.
                    ForEach(proxy.reservedRegions(kind: .division, options: .includeInactive)) { region in
                        FoldGuideShape(region: region)
                    }
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
        }
    }
}

@available(iOS 27.1, *)
private struct FoldGuideShape: View {
    let region: ReservedRegion

    /// The frame minus its margins: the fold itself (zero width on this device).
    private var line: CGRect {
        let m = region.margins
        return CGRect(x: region.frame.minX + m.leading,
                      y: region.frame.minY + m.top,
                      width: region.frame.width - m.leading - m.trailing,
                      height: region.frame.height - m.top - m.bottom)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Keep-out band: the frame, margins included
            Rectangle()
                .fill(Color.purple.opacity(0.18))
                .frame(width: region.frame.width, height: region.frame.height)
                .offset(x: region.frame.minX, y: region.frame.minY)
            // The fold: a line at the reserved rect (solid when active, dashed when not)
            Path { path in
                if line.width < line.height {
                    path.move(to: CGPoint(x: line.midX, y: line.minY))
                    path.addLine(to: CGPoint(x: line.midX, y: line.maxY))
                } else {
                    path.move(to: CGPoint(x: line.minX, y: line.midY))
                    path.addLine(to: CGPoint(x: line.maxX, y: line.midY))
                }
            }
            .stroke(Color.purple, style: StrokeStyle(lineWidth: 3, dash: region.isActive ? [] : [8, 6]))
        }
    }
}
