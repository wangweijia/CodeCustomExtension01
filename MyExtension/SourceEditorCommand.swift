//
//  SourceEditorCommand.swift
//  MyExtension
//
//  Created by apple on 17/11/2016.
//  Copyright © 2016 apple. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        var lastImportIndex = -1
        let importArray: NSMutableArray = NSMutableArray.init()
        
        for r in invocation.buffer.selections {
            let line = (r as! XCSourceTextRange).start.line;
            let colStart = (r as! XCSourceTextRange).start.column
            let colEnd = (r as! XCSourceTextRange).end.column
            if colStart == colEnd {
                break;
            }
            let lineStr = invocation.buffer.lines[line] as! NSString
            let str = lineStr.substring(with: NSMakeRange(colStart, (colEnd-colStart)))
            importArray.add(str)
        }
        
        for lineIndex in 0 ..< invocation.buffer.lines.count {
            let line = invocation.buffer.lines[lineIndex] as! NSString
            do {
                let regex = try NSRegularExpression(pattern: "#import.*", options: .caseInsensitive)
                let range = NSRange(0 ..< line.length)
                let results = regex.matches(in: line as String, options: .reportProgress, range: range)
                
                _ = results.map{ result in
                    lastImportIndex = lineIndex
                }
            }catch{
                completionHandler(error as NSError)
            }
        }
        
        for str in importArray {
            let line = NSString.init(format: "#import \"%@.h\"", str as! CVarArg)
            invocation.buffer.lines.insert(line, at: (lastImportIndex + 1))
        }
        
        completionHandler(nil)
    }
}
