//
//  ViewController.swift
//  Dicee
//
//  Created by Iashin Dmytro on 3/25/18.
//  Copyright © 2018 Dmytro Yashyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer? = nil
    
    let dices: [String] = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    var rightDiceIdx: Int = 0
    var leftDiceIdx: Int = 0

    @IBOutlet weak var leftDice: UIImageView!
    @IBOutlet weak var rightDice: UIImageView!
    
    @IBAction func rollButton(_ sender: UIButton, forEvent event: UIEvent) {
        startRolling(interval: 1)
    }
    
    func startRolling(interval: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.updateDices()
        }
        
        if(interval != 0) {
            Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
                self?.stopRolling()
            }
        }
    }
    
    func stopRolling() {
        timer?.invalidate()
        timer = nil
    }
    
    func getDicesCount() -> UInt32 {
        return UInt32(dices.count);
    }
    
    func getRandomDice(maxIdx: UInt32) -> UIImage {
        let randomIdx = Int(arc4random_uniform(maxIdx))
        return  UIImage(named: dices[randomIdx])!
    }
    
    func updateDices() {
        leftDice.image = getRandomDice(maxIdx: getDicesCount())
        rightDice.image = getRandomDice(maxIdx: getDicesCount())
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        startRolling(interval: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

