//
//  ContentView.swift
//  ViewTest
//
//  Created by Francois Dabonot on 04/10/2024.
//

import SwiftUI
import Combine


internal final class Inspection<V> {

    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}

struct ContentView: View {
    
    @State var valueToDiplay: String = "Waiting for action"
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack {
            Text("Current status: \(valueToDiplay)!")
            Button("Change value") {
                valueToDiplay = "Action done"
            }
        }
        .padding()
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#Preview {
    ContentView()
}
