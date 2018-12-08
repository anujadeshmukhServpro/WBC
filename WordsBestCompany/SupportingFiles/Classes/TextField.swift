//
//  TextField.swift
//  adding currency
//
//  Created by Apoorv Mote on 11/01/16.
//  Copyright © 2016 Apoorv Mote. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) || action == #selector(cut(_:)){
            
            return false
            
        }
        
        return super.canPerformAction(action, withSender: sender)
        
    }

}
