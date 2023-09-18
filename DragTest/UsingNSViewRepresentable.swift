//
//  DraggableText.swift
//  DragTest
//
//  Created by Arenswald, Stephan (059) on 15.09.23.
//

import Foundation
import SwiftUI
import AppKit

class FileURLDragView: NSView, NSDraggingSource {
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .copy
    }
    
    override func mouseDown(with event: NSEvent) {
        print("mouse down")
        // Start an asynchronous operation to fetch the URL
        fetchFileURLAsync { [weak self] url in
            if let url = url {
                self?.startDragOperation(with: url, event: event)
            }
        }
    }

    func startDragOperation(with url: URL, event: NSEvent) {
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(url.absoluteString, forType: .fileURL)

        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        let draggingFrame = bounds
        draggingItem.setDraggingFrame(draggingFrame, contents: "")

        beginDraggingSession(with: [draggingItem], event: event, source: self)
    }

    func fetchFileURLAsync(completion: @escaping (URL?) -> Void) {
        // Perform your asynchronous operation to fetch the URL here.
        // Replace this with your actual async code, e.g., fetching from a network request or reading from a file.
        DispatchQueue.global().async {
            // Simulating an asynchronous operation that fetches the URL.
            let url = URL(fileURLWithPath: "/Users/sarensw/Downloads/bugs/analyze/trigger_174_HU_20230815_160238_CAN/boot/dlt_offlinetrace_collected.dlt")
            DispatchQueue.main.async {
                completion(url)
            }
        }
    }
}

struct FileURLDragViewRepresentable: NSViewRepresentable {
    func makeNSView(context: Context) -> FileURLDragView {
        return FileURLDragView()
    }

    func updateNSView(_ nsView: FileURLDragView, context: Context) {
        // Update the NSView if needed
    }
}

struct UsingNSViewRepresentable: View {
    @Binding var url: URL?
    
    var body: some View {
        VStack {
            Text("UsingNSViewRepresentable")
                .background(FileURLDragViewRepresentable()) // Embed the NSView here
        }
    }
}
