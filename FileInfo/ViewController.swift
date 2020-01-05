//
//  ViewController.swift
//  FileInfo
//
//  Created by qinyuyao on 2020/1/4.
//  Copyright © 2020 qinyuyao. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var document: URL? {
        if let docRepresentedObject = representedObject as? URL {
            return docRepresentedObject
        }
        return nil
    }
    @IBOutlet weak var filePathTextField: NSTextField!
    @IBOutlet weak var fileSizeTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        showFilePath()
        showFileSize()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            for child in children {
                child.representedObject = representedObject
            }
        }
    }

    
    @IBAction func copyFilePathButtonClicked(_ sender: Any) {
        copyStringToPasteboard(string: filePathTextField.stringValue)
    }
    
    
    @IBAction func copyFileSizeButtonClicked(_ sender: Any) {
        copyStringToPasteboard(string: fileSizeTextField.stringValue)
    }
    
}


extension ViewController {
    
    func copyStringToPasteboard(string: String) {
        let pboard = NSPasteboard.general
        pboard.declareTypes([.string], owner: nil)
        pboard.setString(string, forType: .string)
    }
    
    
    func showFilePath() {
        if document != nil {
            filePathTextField.stringValue = document!.path
        }
    }
    
    
    func showFileSize() {
        if document != nil {
            let filePath = filePathTextField.stringValue
            var fileSize: UInt64 = 0
            
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: filePath)
                fileSize = attr[FileAttributeKey.size] as! UInt64
            } catch {
                print("Error: \(error)")
            }
            fileSizeTextField.stringValue = "\(fileSize) Bytes"
        }
    }
    
}

