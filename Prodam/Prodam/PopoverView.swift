//
//  PopoverView.swift
//  Prodam
//
//  Created by Ramon Gilabert Llop on 5/3/15.
//  Copyright (c) 2015 Ramon Gilabert. All rights reserved.
//

import Cocoa

class PopoverView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }

    override func rightMouseDown(theEvent: NSEvent) {
        println("Suppp")
        self.alphaValue = 1
    }

    override func otherMouseDown(theEvent: NSEvent) {
        println("Suppp")
        self.alphaValue = 1
    }

    override func mouseDown(theEvent: NSEvent) {
        println("Suppp")
        self.alphaValue = 1
    }
    
}
