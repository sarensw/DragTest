//
//  UsingNSItemProvider3.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 17.09.23.
//

import Foundation
import SwiftUI

struct UsingNSItemProvider3: View {
    @Binding var url: URL?
    
    var body: some View {
        Text("UsingNSItemProvider3")
            .onDrag {
                let provider = NSItemProvider()

                provider.registerFileRepresentation(for: .fileURL, openInPlace: true) { completionHandler in
                    for i in 0...100000 {
                        print(i)
                    }
                    completionHandler(url, true, nil)
                    return nil
                }
                return provider
            }
    }
}
