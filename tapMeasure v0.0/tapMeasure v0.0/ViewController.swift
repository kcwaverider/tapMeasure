//
//  ViewController.swift
//  tapMeasure v0.0
//
//  Created by Chad Clayton on 10/2/15.
//  Copyright © 2015 Chad Clayton. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var xAxisAcceleration: UILabel!
    @IBOutlet weak var yAxisAcceleration: UILabel!
    @IBOutlet weak var zAxisAcceleration: UILabel!
    
    var manager = CMMotionManager()
    //var myData : CMAccelerometerData
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (manager.accelerometerAvailable) {
            NSLog("Accel available");

            manager.accelerometerUpdateInterval = 0.1
            
            let queue = NSOperationQueue.mainQueue()
            manager.startAccelerometerUpdatesToQueue(queue, withHandler :
                {data, error in

                self.xAxisAcceleration.text = String(format:"%f.3",data!.acceleration.x);
                self.yAxisAcceleration.text = String(format:"%f.3",data!.acceleration.y);
                self.zAxisAcceleration.text = String(format:"%f",data!.acceleration.z);
                
                })
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


        





