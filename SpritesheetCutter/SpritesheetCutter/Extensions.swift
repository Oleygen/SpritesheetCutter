//
//  Extensions.swift
//  SpritesheetCutter
//
//  Created by oleygen ua on 11/18/18.
//  Copyright © 2018 oleygen. All rights reserved.
//

import Foundation
import Cocoa
extension NSTextField
{
    var cgfloat : CGFloat?
    {
        let string = self.stringValue
        if let double = Double(string)
        {
            let cgfloat = CGFloat(double)
            return cgfloat
        }
        else
        {
            return nil
        }
    }
}

extension NSImageView
{
    var renderedImageSize : CGSize
    {
        let originalSize = self.image!.size
        
        switch self.imageScaling {
        case .scaleNone:
            return originalSize
        case .scaleAxesIndependently:
            let sx = self.frame.size.width / originalSize.width
            let sy = self.frame.size.height / originalSize.height
            return CGSize(width: originalSize.width * sx, height: originalSize.height * sy)
        case .scaleProportionallyDown, .scaleProportionallyUpOrDown:
            #warning ("this part is incorrect")
            let sx = self.frame.size.width / originalSize.width
            let sy = self.frame.size.height / originalSize.height
            return CGSize(width: originalSize.width * sx, height: originalSize.height * sy)
        }
    }
    

}


extension NSImage
{
    var pngData :Data
    {
        let imgData = self.tiffRepresentation
        let imageRep = NSBitmapImageRep(data: imgData!)
        let imageProps = [NSBitmapImageRep.PropertyKey.compressionFactor:1.0]
        return imageRep!.representation(using: NSBitmapImageRep.FileType.png, properties: imageProps)!
    }
}
