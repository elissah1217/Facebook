//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Hsin Yi Huang on 6/3/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    var backgroundAlpha: CGFloat!
    var imageArray: [UIImageView]!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
  
    @IBOutlet weak var actionImageView: UIImageView!
    var currentImageIndex: Int!
    
   // var zoomImageView: UIImageView!
    
    @IBOutlet weak var zoomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.clipsToBounds = true
        println(imageView.alpha)
        
        println("currentImageIndex = \(currentImageIndex)")
        
        imageArray = [UIImageView]()
        for var i = 0; i < 5; i++
        {
            var singleImageView = UIImageView()
            singleImageView.image = UIImage(named:"wedding\(i+1)")
            singleImageView.frame.size = CGSize(width:320, height:452)
            singleImageView.contentMode = UIViewContentMode.ScaleAspectFill
            singleImageView.clipsToBounds = true
            var pinchGesture = UIPinchGestureRecognizer(target: self, action: "onPinch:")
            //singleImageView.addGestureRecognizer(pinchGesture)
            //singleImageView.userInteractionEnabled = true
            //singleImageView.multipleTouchEnabled = true
            singleImageView.frame.origin.x = CGFloat(i * 320)
            imageArray.append(singleImageView)
            scrollView.addSubview(imageArray[i])
        }
        
        scrollView.contentSize = CGSize(width: 1600, height: 453)
        scrollView.delegate = self
        scrollView.contentOffset.x = CGFloat(currentImageIndex * 320)
        
        
        backgroundAlpha = 1
        
        

        
        //testing purpose
        imageView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        println("did sroll")
        
        if scrollView.zoomScale == 1{
            backgroundAlpha = progressValue(scrollView.contentOffset.y, refValueMin: 0, refValueMax: -150, convertValueMin: 1, convertValueMax: 0)
            
            if backgroundAlpha < 0{
                backgroundAlpha = 0
            }
            scrollView.backgroundColor = UIColor(white:0, alpha: backgroundAlpha)
            self.view.backgroundColor = UIColor(white:0, alpha: backgroundAlpha)
            doneButton.alpha = backgroundAlpha
            actionImageView.alpha = backgroundAlpha
        }
        
    }
    
    

    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            println("end dragging")

            if scrollView.contentOffset.y < -100 && scrollView.zoomScale == 1{
                self.view.alpha = 0
                    dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        println("view for zoom")
        println(scrollView.contentSize)
        

    //return imageView
       return imageArray[currentImageIndex]

    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){

        if scrollView.zoomScale == 1{
            currentImageIndex = Int(scrollView.contentOffset.x/320)
        }
        
        println("current index \(currentImageIndex)")
        
    }
    
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView!){
        scrollView.pagingEnabled = false
        scrollView.directionalLockEnabled = false
        scrollView.addSubview(imageArray[currentImageIndex])
        scrollView.contentSize = CGSize(width: 320, height: 453)
        scrollView.contentOffset.x = 0
        
        imageArray[currentImageIndex].frame.origin.x = 0
        
        for var i = 0; i < 5; i++
        {
            if i != currentImageIndex{
                imageArray[i].alpha = 0
            }
        }
        
    }
    

    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        println(scrollView.contentSize)
        if scrollView.zoomScale == 1{
            for var i = 0; i < 5; i++
            {
                if i != currentImageIndex {
                    imageArray[i].alpha = 1
                }
            }
            scrollView.directionalLockEnabled = true
            scrollView.contentOffset.x = CGFloat(currentImageIndex * 320)
            imageArray[currentImageIndex].frame.origin.x = CGFloat(currentImageIndex * 320)
            scrollView.pagingEnabled = true
            scrollView.contentSize = CGSize(width:1600, height: 453)
        }
    }
    
 
    

    
    
   
    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func progressValue(value: CGFloat, refValueMin: CGFloat, refValueMax: CGFloat, convertValueMin: CGFloat, convertValueMax: CGFloat) -> CGFloat {
        
        var ratio = (value - refValueMin)/(refValueMax - refValueMin)
        var currentValue = (convertValueMax - convertValueMin)*ratio + convertValueMin
        return currentValue
    }
   

}
