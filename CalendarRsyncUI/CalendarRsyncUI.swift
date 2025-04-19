
import Foundation
import OSLog
import SwiftUI

@main
struct CalendarRsyncUI: App {
    var body: some Scene {
        Window("Calendar for RsyncUI", id: "main") {
            StartCalendar()
                .frame(minWidth: 1100, idealWidth: 1300, minHeight: 510)
        }
    }
}

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!
    static let process = Logger(subsystem: subsystem, category: "process")
}

extension Thread {
    static var isMain: Bool { isMainThread }
}
