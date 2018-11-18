//
//  ViewController.swift
//  SpritesheetCutter
//
//  Created by oleygen ua on 11/18/18.
//  Copyright © 2018 oleygen. All rights reserved.
//

import Cocoa

class InitialViewController: NSViewController {

    var savedImage: NSImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func didClickButton(_ sender: NSButton) {
        let panel = NSOpenPanel()

        panel.begin { response in
            if response == NSApplication.ModalResponse.OK
            {
                if let url = panel.url
                {
                    self.fetchImage(from: url)
                    self.performSegue(withIdentifier: "initialToImage", sender: self.savedImage)
                }
                
            }
        }
    }
    
    
    private func fetchImage(from url: URL)
    {
        savedImage = NSImage(byReferencing: url)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "initialToImage")
        {
            let target = segue.destinationController as! ImageViewController
            target.image = self.savedImage!
        }
    }
}

