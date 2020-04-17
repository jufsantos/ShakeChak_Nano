//
//  ViewController.swift
//  ShakeChak
//
//  Created by Julia Santos on 17/04/20.
//  Copyright © 2020 Julia Santos. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    
    let motion = CMMotionManager()
    
   public override func viewDidLoad() {
        super.viewDidLoad()

        startAccelerometers()
        
    }
    func startAccelerometers() {
        // Make sure the accelerometer hardware is available.
        
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motion.startAccelerometerUpdates()

            
            // Configure a timer to fetch the data.
            let timer = Timer(fire: Date(), interval: (1.0/60.0),
                              repeats: true, block: { (timer) in
                                // Get the accelerometer data.
                                if let data = self.motion.accelerometerData {
                                    
                                    let x = data.acceleration.x
                                    let y = data.acceleration.y
                                    let z = data.acceleration.z
                                    
                                    print(x, y, z)
                                    
                                    if abs(x) > 1 || abs(y) > 1 || abs(z) > 1 {
                                        DispatchQueue.main.async {
                                            self.image1.image = UIImage(named: "chocalho")
                                        }
                                    } else{
                                        DispatchQueue.main.async {
                                            self.image1.image = UIImage(named: "chocalho2")
                                        }
                                    }
                                }
            })
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        }
    }
}

