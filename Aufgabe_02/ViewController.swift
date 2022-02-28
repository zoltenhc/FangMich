//  Prüfungsarbeit PR_179_01
//  ViewController.swift
//  Programmieraufgaben Apps mit grafischer Oberfläche
//  Aufgabe_02
//
//  Created by Zoltán Gál on 2020. 12. 02..
//  Copyright © 2020. Zoltán Gál. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var tasteWechseln,bleibZeit, stopSpiel: Timer!
    var zeit = 120
    
    @IBOutlet weak var tasteFangMich: NSButton!
    @IBOutlet weak var punkte: NSTextField!
    @IBOutlet weak var start: NSButton!
    @IBOutlet weak var verbliebeneZeit: NSTextField!
    
    
    @IBAction func gefangenTaste(_ sender: Any) {
        if punkte.integerValue < 10 {
            punkte.integerValue = punkte.integerValue + 1
            punkte.sizeToFit()
        }
        if punkte.integerValue == 10 {
            tasteWechseln.invalidate()
            bleibZeit.invalidate()
            stopSpiel.invalidate()
            let meinemeldung : NSAlert = NSAlert()
            meinemeldung.messageText = "Hinweis"
            meinemeldung.informativeText = "Herzlichen Glückwunsch"
            meinemeldung.runModal()
            NSApplication.shared.terminate(self)
        }
    }
    
    @objc func verbliebeneZeitTimer() {
        zeit = zeit - 1
        verbliebeneZeit.integerValue = zeit
        verbliebeneZeit.sizeToFit()
    }
    
    @objc func stopTimer() {
        if zeit < 1 {
            tasteWechseln.invalidate()
            bleibZeit.invalidate()
            stopSpiel.invalidate()
            let meinemeldung : NSAlert = NSAlert()
            meinemeldung.messageText = "Hinweis"
            meinemeldung.informativeText = "Sie haben leider verloren"
            meinemeldung.runModal()
            NSApplication.shared.terminate(self)
            }
    }
    
    @IBAction func startSpiel(_ sender: Any) {
        tasteFangMich.isEnabled = true
        start.isEnabled = false
        tasteWechseln = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(wechsel), userInfo: nil, repeats: true)
        bleibZeit = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(verbliebeneZeitTimer), userInfo: nil, repeats: true)
        stopSpiel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stopTimer), userInfo: nil, repeats: true)
    }
    
    @objc func wechsel() {
    
        let tasteBreite = tasteFangMich.frame.width
        let tasteHoehe = tasteFangMich.frame.height

        let viewBreite = tasteFangMich.superview!.bounds.width
        let viewHoehe = tasteFangMich.superview!.bounds.height
        
        let xBreite = viewBreite - tasteBreite
        let yHoehe = viewHoehe - tasteHoehe

        let xoffset = CGFloat(arc4random_uniform(UInt32(xBreite)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yHoehe-50)))
        tasteFangMich.frame.origin = CGPoint(x: xoffset, y: yoffset + 50)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasteFangMich.isEnabled = false
        verbliebeneZeit.integerValue = zeit
        verbliebeneZeit.sizeToFit()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

