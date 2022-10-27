
import SwiftUI

@main
struct voidApp: App {
    init() { RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0)) }
    
    var body: some Scene {
        WindowGroup {
            SwitchView()
        }
    }
}
