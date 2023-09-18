//
//  UsingTransferable.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 17.09.23.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct AnyFileTransferableData: Codable, Transferable {
    let url: URL
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .fileURL) { item in
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return item.url.dataRepresentation
        } importing: { received in
            return Self.init(url: URL(filePath: ""))
        }
    }
}

struct AnyFileTransferableProxy: Codable, Transferable {
    let url: URL
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.url)
        ProxyRepresentation<AnyFileTransferableProxy, URL> (exporting: { item in
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return item.url
        })
    }
}

struct AnyFileTransferableCodable: Codable, Transferable {
    let url: URL
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .fileURL)
    }
}

struct AnyFileTransferableFile: Codable, Transferable {
    let url: URL
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: UTType(filenameExtension: "dlt")!) {
            SentTransferredFile($0.url)
        } importing: { received in
            return Self.init(url: URL(filePath: ""))
        }
    }
}

struct UsingTransferable: View {
    @Binding var url: URL?
    
    var body: some View {
        Text("UsingTransferableData")
            .draggable(AnyFileTransferableData(url: url!), preview: {
                Text("UsingTransferableData")
            })
        Text("UsingTransferableProxy")
            .draggable(AnyFileTransferableProxy(url: url!), preview: {
                Text("UsingTransferableProxy")
            })
        Text("UsingTransferableCodable")
            .draggable(AnyFileTransferableCodable(url: url!), preview: {
                Text("UsingTransferableCodable")
            })
        Text("UsingTransferableFile")
            .draggable(AnyFileTransferableFile(url: url!), preview: {
                Text("UsingTransferableFile")
            })
    }
}
