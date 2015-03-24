//
//  SnowViewController.swift
//  SnowDemo
//
//  Created by Brian Jordan on 3/23/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class SnowViewController: UIViewController, UICollisionBehaviorDelegate {

    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var collision:UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)

        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "addSnowFlake", userInfo: nil, repeats: true)
        
        collision.addBoundaryWithIdentifier("shelf", fromPoint:CGPointMake(0, 200), toPoint:CGPointMake(150, 240))
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
    }
    
    func addSnowFlake() {
        var boundsWidth:CGFloat = CGRectGetWidth(view.bounds)
        var randomX = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * boundsWidth
        var snow = UIView(frame: CGRectMake(randomX, 0.0, 10, 10))
        snow.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(snow)
        gravity.addItem(snow)
        collision.addItem(snow)
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem) {
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        delay(0.2) {
            self.meltSnow(item as UIView)
        }
    }
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying) {

    }
    
    func meltSnow(snowView: UIView) {
        UIView.animateWithDuration(1.0, animations: {
            snowView.alpha = 0.0
            }, completion: { (bool: Bool) -> Void in
                self.collision.removeItem(snowView)
                self.gravity.removeItem(snowView)
                snowView.removeFromSuperview()
        })
    }

    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
