//
//  SFFilePickerVC.swift
//  JohnWick
//
//  Created by sfh on 2022/7/23.
//

import SFStyleKit
import UIKit

public extension SFExStyle where Base: SFFilePickerVC {
    @discardableResult
    func complete(_ complete: @escaping (URL, Data?) -> ()) -> SFExStyle {
        base.complete = complete
        return self
    }
    
    @discardableResult
    func show() -> SFExStyle {
        base.show()
        return self
    }
}

public class SFFilePickerVC: UIDocumentPickerViewController {
    fileprivate var complete: ((URL, Data?) -> ())?
    
    public init(complete: ((URL, Data?) -> ())? = nil) {
        let documentTypes = [
            "public.content",
            "public.text",
            "public.source-code",
            "public.image",
            "public.audiovisual-content",
            "com.adobe.pdf",
            "com.apple.keynote.key",
            "com.microsoft.word.doc",
            "com.microsoft.excel.xls",
            "com.microsoft.powerpoint.ppt"
        ]
        super.init(documentTypes: documentTypes, in: .open)
        self.complete = complete
        self.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
        SF.visibleVC?.present(self, animated: true, completion: nil)
    }
}

// MARK: UIDocumentPickerDelegate

extension SFFilePickerVC: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileUrl = urls.first else {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        SFiCloudManager.shared.download(with: fileUrl) { [weak self] data in
            guard let self = self else { return }
            self.complete?(fileUrl, data)
            controller.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: SFiCloudManager

public class SFiCloudManager: NSObject {
    public static let shared = SFiCloudManager()
    
    public func iCloudEnable() -> Bool {
        return FileManager.default.url(forUbiquityContainerIdentifier: nil) != nil
    }
    
    public func download(with fileUrl: URL, completion: ((Data?) -> ())? = nil) {
        let document = SFDocument(fileURL: fileUrl)
        document.open { success in
            if success {
                document.close(completionHandler: nil)
            }
            completion?(document.data)
        }
    }
}

// MARK: SFDocument

public class SFDocument: UIDocument {
    public var data: Data?
    
    override public func load(fromContents contents: Any, ofType typeName: String?) throws {
        data = contents as? Data
    }
}
