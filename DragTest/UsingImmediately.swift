//
//  UsingImmediately.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 18.09.23.
//

import Foundation
import SwiftUI

struct UsingImmediately: View {
    @Binding var url: URL?
    
    var body: some View {
        Text("UsingImmediately")
            .onDrag {
                let itemProvider = NSItemProvider(contentsOf: url)
                return itemProvider!
            }
    }
}
