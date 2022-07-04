import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: {
                        ReactView(with: "todo")
                            .navigationTitle("Todo")
                            .navigationBarTitleDisplayMode(.inline)
                    },
                    label: { Text("Todo") }
                )
            }
            .navigationTitle("ReconcilerSample")
        }
    }
}
