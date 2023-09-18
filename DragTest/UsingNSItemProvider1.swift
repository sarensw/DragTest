//
//  UsingNSItemProvider1.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 17.09.23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

class AnyFileNSItemProviderWriting: NSObject, NSItemProviderWriting {
    let url: URL
    init(url: URL) {
        self.url = url
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [UTType.fileURL.identifier]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping @Sendable (Data?, Error?) -> Void) -> Progress? {
        let count = 100000
        let progress = Progress(totalUnitCount: Int64(count))
        print("1")
        Task.detached {
            print("2")
            for i in 0...100000 {
                progress.completedUnitCount = Int64(i)
                print(i)
            }
            print("3")
            completionHandler(self.url.dataRepresentation, nil)
            print("4")
        }
        print("5")
        return progress
    }
}

struct UsingNSItemProvider1: View {
    @Binding var url: URL?
    
    var body: some View {
        Text("UsingNSItemProvider1")
            .onDrag {
                print(6)
                let provider = NSItemProvider(object: AnyFileNSItemProviderWriting(url: url!))
                print(7)
                return provider
            }
    }
}
