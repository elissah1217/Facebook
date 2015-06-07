//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var selectedImageView: UIImageView!
    var imageTransition: ImageTransition!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    var imageArray: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        imageArray = [image1, image2, image3, image4, image5]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    
    
    @IBAction func onImageTap(sender: UITapGestureRecognizer) {
        selectedImageView = sender.view as! UIImageView
        performSegueWithIdentifier("imageSegue", sender: self)
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepare for segue")
        var destinationViewController = segue.destinationViewController as! PhotoViewController
        //println(destinationViewController.imageView.image)
        
        var currentImageIndex = 0
        
        for var i = 0; i < imageArray.count; i++
        {
            if imageArray[i] == selectedImageView{
                currentImageIndex = i
            }
        }
        
        println(currentImageIndex)
        destinationViewController.currentImageIndex = currentImageIndex
        
        destinationViewController.image = self.selectedImageView.image
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        imageTransition = ImageTransition()
        //imageTransition.duration = 0.7
        
         destinationViewController.transitioningDelegate = imageTransition
         imageTransition.feedViewController = self
        
    }
    
    
    
    
    
}
