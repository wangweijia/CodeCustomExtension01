//
//  SourceEditorExtension.swift
//  MyExtension
//
//  Created by apple on 17/11/2016.
//  Copyright © 2016 apple. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
    }
    
//    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
//        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
//        print("commandDefinitions")
//        return [[XCSourceEditorCommandDefinitionKey(rawValue: "XCSourceEditorCommandName"): "wwj"]]
//    }
}
