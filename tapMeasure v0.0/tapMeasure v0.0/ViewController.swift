//
//  ViewController.swift
//  tapMeasure v0.0
//
//  Created by Chad Clayton on 10/2/15.
//  Copyright © 2015 Chad Clayton. All rights reserved.
//

import UIKit
import CoreMotion
import Darwin


class ViewController: UIViewController {
    @IBOutlet weak var xAxisAcceleration: UILabel!
    @IBOutlet weak var yAxisAcceleration: UILabel!
    @IBOutlet weak var zAxisAcceleration: UILabel!
    @IBOutlet weak var yAxisDistance: UILabel!
    @IBOutlet weak var yAxisSpeed: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!

    
    
    
    var manager = CMMotionManager()
    var ySpeed = 0.0
    var yDistance = 0.0
    var yCalibrationArray = [Double]()
    var yCalibration = 0.0
    
    var yAccel = 0.0
    var xAccel = 0.0
    var zAccel = 0.0
    let updateInterval = 0.01
    
    //var myData : CMAccelerometerData
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (manager.accelerometerAvailable) {
            NSLog("Accel available");

            manager.accelerometerUpdateInterval = updateInterval
            
            let queue = NSOperationQueue.mainQueue()
            manager.startAccelerometerUpdatesToQueue(queue, withHandler :
                {data, error in
                    
                    self.yAccel = data!.acceleration.y * 9.7997
                    self.xAccel = data!.acceleration.x * 9.7997
                    self.zAccel = data!.acceleration.z * 9.7997
                    
                    self.yCalibrationArray.append(self.yAccel - self.yCalibration)
                    self.ySpeed += self.yCalibrationArray.last! * self.updateInterval
                    self.yDistance += self.ySpeed * self.updateInterval
                    self.yAxisAcceleration.text = String(format:"%f",self.yCalibrationArray.last!);
                    self.yAxisSpeed.text = String(format:"%f in/sec", self.ySpeed)
                    self.yAxisDistance.text = String(format:"%f in", self.yDistance)
                    
                    
                    self.xAxisAcceleration.text = String(format:"%f",self.xAccel);
                    self.zAxisAcceleration.text = String(format:"%f",self.zAccel);
                    
                    self.gravityLabel.text = String(format:"%f", sqrt (pow(self.xAccel,2) + pow(self.yAccel,2) + pow(self.zAccel,2) ) )
                    
                
                })
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calibrateButton(sender: UIButton) {
        let tempArray:[Double] = self.yCalibrationArray
        let array:[String] = tempArray.map({item in "\(item)"})
        self.yCalibration = (tempArray.reduce(0, combine: +) / Double(tempArray.count))
        self.yCalibrationArray.removeAll()
        NSLog("Calibration: %f", self.yCalibration)
        self.yDistance = 0.0
        self.ySpeed = 0.0
        let joined = array.joinWithSeparator(",")
        
        NSLog(joined)
    }
}








