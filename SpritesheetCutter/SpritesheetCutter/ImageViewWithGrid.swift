//
//  ImageViewWithGrid.swift
//  SpritesheetCutter
//
//  Created by oleygen ua on 11/18/18.
//  Copyright © 2018 oleygen. All rights reserved.
//

import Cocoa

class ImageViewWithGrid: NSImageView {
    var bezierPath: NSBezierPath?
    var gridColor : NSColor?
    var showGrid: Bool = false

    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
                
        if (showGrid)
        {
            gridColor?.setStroke()
            bezierPath?.stroke()
        }
    }
    
}
