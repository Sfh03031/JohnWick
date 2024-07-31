//
//  SFFileBrowser.swift
//  JohnWick
//
//  Created by sfh on 2024/7/23.
//

import QuickLook
import UIKit

public extension SF {
    static var fileBrower: SFFileBrowser.Type {
        SFFileBrowser.self
    }
}

public class SFFileBrowser: QLPreviewController {
    private var fileUrl: URL?
    
    public init(fileUrl: URL? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
        self.dataSource = self
        self.fileUrl = fileUrl
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
        SF.visibleVC?.present(self, animated: true, completion: nil)
    }
}

// MARK: QLPreviewControllerDelegate, QLPreviewControllerDataSource

extension SFFileBrowser: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return self.fileUrl == nil ? 0 : 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return (self.fileUrl ?? URL(fileURLWithPath: "")) as QLPreviewItem
    }
}
