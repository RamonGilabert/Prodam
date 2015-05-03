//
//  PopoverControllerGreat.swift
//  Prodam
//
//  Created by Ramon Gilabert Llop on 5/3/15.
//  Copyright (c) 2015 Ramon Gilabert. All rights reserved.
//

import Cocoa

class PopoverWindowController: NSWindowController {

    let popover = NSPopover()

    override func loadWindow() {
        self.window = NSWindow_Popover(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popover.contentViewController = PopoverController()
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
    }
}
