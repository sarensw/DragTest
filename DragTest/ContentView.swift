//
//  ContentView.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 15.09.23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @AppStorage("url") var url: URL?

    var body: some View {
        VStack(spacing: 8) {
            TextField("Link URL", text: Binding(
                get: { url?.absoluteString ?? "" },
                set: { url = URL(string: $0) }
            ))
            UsingImmediately(url: $url)
            UsingNSItemProvider1(url: $url)
            UsingNSItemProvider2(url: $url)
            UsingNSItemProvider3(url: $url)
            UsingTransferable(url: $url)
            UsingNSViewRepresentable(url: $url)
        }
        .padding()
    }
}
