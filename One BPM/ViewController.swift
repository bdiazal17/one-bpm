//
//  ViewController.swift
//  One BPM
//
//  Created by Brian Diaz Alvarez on 16/03/2020.
//  Copyright © 2020 Brian Diaz Alvarez. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var BPMLabel: UILabel!
    @IBOutlet var startupView: UIView!
    @IBOutlet var BPMView: UIView!
    @IBOutlet var SecondaryView: UIView!
    @IBOutlet var LongPressRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var ShortLongPressRecognizer: UILongPressGestureRecognizer!
    
    var FlashScreenView: UIView!
    
    var bpms = [Int]();
    var currentBPM = 0;
    var tapCount = 0;
    var currentTapTimestamp: Date = Date.init();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeFlashScreen();
        LongPressRecognizer.delegate = self;
        ShortLongPressRecognizer.delegate = self;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
    @IBAction func handleShortLongPress(_ sender: UILongPressGestureRecognizer){
        switch sender.state {
        case .ended:
            FlashScreenView.isHidden = true;
            break;
        case .began:
            handleTap();
            break;
        default:
            FlashScreenView.isHidden = false;
            break;
        }
    }

    // Long press resets app state.
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer){
        if(tapCount <= 0){
            return;
        }
        bpms = [Int]();
        currentBPM = 0;
        tapCount = 0;
        currentTapTimestamp = Date.init();
        self.BPMLabel?.text = String(currentBPM);
    }
    
    func calculateBPM() -> Int{
        let bpmTotal = bpms.reduce(0,+);
        return (bpmTotal/bpms.count);
    }
    
    func initializeFlashScreen(){
        if let wnd = self.view{
            FlashScreenView = UIView(frame: wnd.bounds)
            FlashScreenView.backgroundColor = .white;
            FlashScreenView.alpha = 0.2
            FlashScreenView.isUserInteractionEnabled = false;
            FlashScreenView.isHidden = true;
            wnd.addSubview(FlashScreenView);
        }
    }
    
    func handleTap(){
        if(tapCount==0 && SecondaryView.isHidden){
            SecondaryView.animShow();
        }
        let previousTapTimestamp = currentTapTimestamp;
        currentTapTimestamp = Date.init();
        tapCount+=1;
        self.BPMLabel?.text = String(currentBPM);
        startupView.isHidden = true;
        BPMView.isHidden = false;
        if(tapCount <= 1){
            return;
        }
        var currentTapDifference: TimeInterval = previousTapTimestamp.timeIntervalSinceNow;
        currentTapDifference = abs(currentTapDifference);
        let tempBpm = 60/currentTapDifference;
        if(bpms.count > 9){
            bpms.removeFirst();
        }
        bpms.append(Int(tempBpm))
        currentBPM = calculateBPM();
        self.BPMLabel?.text = String(currentBPM);
    }
}

