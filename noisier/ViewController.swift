//
//  ViewController.swift
//  noisier
//
//  Created by Kari Silvennoinen on 07.07.2018.
//  Copyright © 2018 Kalifi.org. All rights reserved.
//

import Cocoa
import AudioToolbox

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let noise = NoiseRenderer()
        noise.createNoiseUnit()
        AudioUnitInitialize(noise.noiseUnit!)
        AudioOutputUnitStart(noise.noiseUnit!)
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

