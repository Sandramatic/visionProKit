//
//  BaseApp.swift
//  Base
//
//  Created by Sandra Feng on 2025-02-10.
//

import SwiftUI

@main
struct BaseApp: App {
    
    @State private var appModel = AppModel()
    @State private var avPlayerViewModel = AVPlayerViewModel()
    @State private var tracking = Tracking()
    var body: some Scene {
        WindowGroup {
            if avPlayerViewModel.isPlaying {
                AVPlayerView(viewModel: avPlayerViewModel)
            } else {
                ContentView()
                    .environment(appModel)

            }
        }
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .environment(tracking)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                    avPlayerViewModel.play()
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    avPlayerViewModel.reset()
                }
        }
        // set immersion style to mix as default, need to use a variable to change the mode
        .immersionStyle(selection: .constant(.mixed), in: .full, .mixed,.progressive)
    }
}
