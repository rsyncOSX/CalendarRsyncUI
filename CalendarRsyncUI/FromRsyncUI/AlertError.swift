import Foundation
import Observation
import SwiftUI

enum NumDayofweek: Int {
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    case Sunday = 1
}

@Observable @MainActor
final class AlertError {
    private(set) var activeError: Error?

    func alert(error: Error) {
        activeError = error
    }

    var presentalert: Binding<Bool> {
        Binding<Bool>(
            get: { self.activeError != nil },
            set: { value in
                guard !value else { return }
                self.activeError = nil
            }
        )
    }
}

extension Alert {
    init(localizedError: Error) {
        self = Alert(nsError: localizedError as NSError)
    }

    init(nsError: NSError) {
        let message: Text? = {
            let message = [nsError.localizedFailureReason,
                           nsError.localizedRecoverySuggestion]
                .compactMap(\.self).joined(separator: "\n\n")
            return message.isEmpty ? nil : Text(message)
        }()
        self = Alert(title: Text(nsError.localizedDescription),
                     message: message,
                     dismissButton: .default(Text("OK")))
    }
}
