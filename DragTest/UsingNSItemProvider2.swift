//
//  UsingNSItemProvider2.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 17.09.23.
//

import Foundation
import SwiftUI

struct UsingNSItemProvider2: View {
    @Binding var url: URL?
    
    var body: some View {
        Text("UsingNSItemProvider2")
            .onDrag {
                for i in 0...100000 {
                    print(i)
                }
                let itemProvider = NSItemProvider(contentsOf: url)
                return itemProvider!
            }
    }
}
