//
//  ImageViewController.swift
//  SpritesheetCutter
//
//  Created by oleygen ua on 11/18/18.
//  Copyright © 2018 oleygen. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController {
    
    var image: NSImage?
    
    @IBOutlet weak var imageView: ImageViewWithGrid!
    @IBOutlet weak var rowsTextField: NSTextField!
    @IBOutlet weak var columnsTextField: NSTextField!
    @IBOutlet weak var gridColorWell: NSColorWell!
    
    var gridColor: NSColor
    {
        return gridColorWell.color
    }
    
    var bezierPath: NSBezierPath?
    var displayGrid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
        self.imageView.gridColor = self.gridColor
    }
    
    
    
    @IBAction func didClickShowGridButton(_ sender: NSButton) {
        let rows = rowsTextField.cgfloat!
        let columns = columnsTextField.cgfloat!

        let actualImageSize = self.imageView.renderedImageSize
        
        let rowLength = actualImageSize.height/rows
        let columnLength = actualImageSize.width/columns
        
        self.imageView.bezierPath = createBezierPath(rowLength: rowLength, columnLength: columnLength)
        self.imageView.showGrid = true
        self.imageView.setNeedsDisplay()

    }
    
    @IBAction func didClickSaveSlicesButton(_ sender: NSButton) {
      
        let images = sliceImage()
        let savePanel = NSSavePanel()
        savePanel.begin { response in
            if response == NSApplication.ModalResponse.OK
            {
                var i = 0
                let path = savePanel.directoryURL!.relativePath
                
                images.forEach({ image in
                    let finalPath = path + "/" + String(i) + ".png"
                    let url = URL(fileURLWithPath: finalPath)
                    try! image.pngData.write(to: url)
                    i = i + 1
                })
            }
        }
        
        
    }
    
    @IBAction func didChangeGridColor(_ sender: NSColorWell) {
        self.imageView.gridColor = self.gridColor
    }
    
    private func createBezierPath(rowLength: CGFloat, columnLength: CGFloat) -> NSBezierPath
    {
        
        let actualImageSize = self.imageView.renderedImageSize
        
        let width = actualImageSize.width
        let height = actualImageSize.height
        
        let bezierPath = NSBezierPath()
        bezierPath.lineWidth = 1.0
        
        for i in stride(from: 0, to: height, by: rowLength)
        {
            bezierPath.move(to: NSPoint(x: 0, y: i))
            bezierPath.line(to: NSPoint(x: width, y: i))
        }
        for j in stride(from: 0, to: width, by: columnLength)
        {
            bezierPath.move(to: NSPoint(x: j, y: 0))
            bezierPath.line(to: NSPoint(x: j, y: height))
            
        }
        return bezierPath
    }
    
    private func sliceRects(for size: CGSize) -> [CGRect]
    {
        let intRows = rowsTextField.intValue
        let intColumns = columnsTextField.intValue
        let rows = rowsTextField.cgfloat!
        let columns = columnsTextField.cgfloat!
        
        let tileHeight = size.height/rows
        let tileWidth = size.width/columns
        
        var rects = [CGRect]()
        
        for i in 0..<intColumns
        {
            for j in 0..<intRows{
                let rectToSlice = CGRect(x: CGFloat(i) * tileWidth, y: CGFloat(j) * tileHeight, width: tileWidth, height: tileHeight)
                rects.append(rectToSlice)
            }
        }
        return rects
    }
    
    private func sliceImage() -> [NSImage]
    {
        
        let originalSize = self.image!.size
        
        var originalImageRect : CGRect = CGRect(x: 0, y: 0, width: originalSize.width, height: originalSize.height)
        let imageRef = self.image!.cgImage(forProposedRect: &originalImageRect, context: nil, hints: nil)
        
        var images = [NSImage]()
        
        let rects = self.sliceRects(for: CGSize(width: imageRef!.width, height: imageRef!.height))

        
        rects.forEach { rect in
            let slice = imageRef?.cropping(to: rect)
            let newImage = NSImage(cgImage: slice!, size: rect.size)
            images.append(newImage)
        }
        
        return images
    }
}
