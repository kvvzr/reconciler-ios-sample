import SwiftUI
import SwiftYogaKit

@main
struct ReconcilerSampleApp: App {
    init() {
        UIView.SwiftYogaKitSwizzle()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
