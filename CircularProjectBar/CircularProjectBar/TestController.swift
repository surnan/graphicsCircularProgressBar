//
//  ViewController.swift
//  CircularProjectBar
//
//  Created by admin on 11/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class TestController: UIViewController, URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finishing downloading file")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Total Written = \(totalBytesWritten)   .... Total Expected to \(totalBytesExpectedToWrite)")

        let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        print("Total Written = \(totalBytesWritten)   .... Total Expected to \(totalBytesExpectedToWrite) ... % = \(percentage)")
    }
    
    
    let shapeLayer = CAShapeLayer()
    let layer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blue
       
        //layer
        let bounds = CGRect(x: 50, y: 50, width: 250, height: 250)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = nil
        layer.lineDashPattern = [8, 6]
        view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "line")
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
     
        //Track-Line
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round  //very small visual.  How the line end points look
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        
        //drawing circle
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0    //Without this line, the circle appears surrounded by Green Ring @start
        shapeLayer.lineCap = .round  //very small visual.  How the line end points look
        //shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
    }
    
         let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"

    func beginDownloadingFile(){
        print("Downloading File")
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue()) //operationQueue is the queue where we execute our download tasks
        
        guard let url = URL(string: urlString) else {return}
        let downloadTask = urlSession.downloadTask(with: url)
            downloadTask.resume()   //kick-off the download
    }
    
    fileprivate func animateCircle() {
        //strokeEnd --> 0 = beginning of path & 1 = end of path
        shapeLayer.strokeEnd = 0 //initial value
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1 //ending value
        basicAnimation.fillMode = .backwards
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        
        
        shapeLayer.add(basicAnimation, forKey: "appleSauze")
    }
    
    @objc func handleTap(){
        beginDownloadingFile()
        animateCircle() //Key can be any random string //notice it's different than other CBasicAnimation lines
    }
    
    
    
    
    
    
    
}

