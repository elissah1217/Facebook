//
//  ImageTransition.swift
//  Facebook
//
//  Created by Hsin Yi Huang on 6/4/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
 
    var newsImageViewSize: CGSize!
    var newsImageViewOrigin: CGPoint!
    var transitionImageView: UIImageView!
    var feedViewController: NewsFeedViewController!
    
    var photoImageViewOrigin: CGPoint!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        
        var photoViewController = toViewController as! PhotoViewController
        containerView.backgroundColor = UIColor(white:0, alpha:0)
        
        
        newsImageViewSize = feedViewController.selectedImageView.frame.size
        newsImageViewOrigin = CGPoint(x: feedViewController.selectedImageView.frame.origin.x, y:feedViewController.selectedImageView.frame.origin.y + feedViewController.scrollView.frame.origin.y - feedViewController.scrollView.contentOffset.y)
        photoImageViewOrigin = CGPoint(x: photoViewController.imageView.frame.origin.x, y: photoViewController.imageView.frame.origin.y + photoViewController.scrollView.frame.origin.y - photoViewController.scrollView.contentOffset.y)
        
        transitionImageView = UIImageView()
        transitionImageView.contentMode = UIViewContentMode.ScaleAspectFill
        transitionImageView.clipsToBounds = true
        transitionImageView.image = feedViewController.selectedImageView.image
        transitionImageView.frame.size = newsImageViewSize
        transitionImageView.frame.origin = newsImageViewOrigin
        
        var window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(transitionImageView)
        
        toViewController.view.alpha = 0

        UIView.animateWithDuration(duration, animations: {
            containerView.backgroundColor = UIColor(white:0, alpha:1)
            self.transitionImageView.frame.size = photoViewController.imageView.frame.size
            self.transitionImageView.frame.origin = self.photoImageViewOrigin
            }) { (finished: Bool) -> Void in
                toViewController.view.alpha = 1
                println("remove")
                containerView.backgroundColor = UIColor(white:0, alpha:0)
                self.transitionImageView.removeFromSuperview()
                self.finish()
                
                
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        var photoViewController = fromViewController as! PhotoViewController
       // var feedViewController = toViewController as! NewsFeedViewController
        
        containerView.backgroundColor = UIColor(white:0, alpha:photoViewController.backgroundAlpha)
        
        photoImageViewOrigin = CGPoint(x: photoViewController.imageView.frame.origin.x, y: photoViewController.imageView.frame.origin.y + photoViewController.scrollView.frame.origin.y - photoViewController.scrollView.contentOffset.y)
        newsImageViewSize = feedViewController.imageArray[photoViewController.currentImageIndex].frame.size
        newsImageViewOrigin = CGPoint(x: feedViewController.imageArray[photoViewController.currentImageIndex].frame.origin.x, y:feedViewController.imageArray[photoViewController.currentImageIndex].frame.origin.y + feedViewController.scrollView.frame.origin.y - feedViewController.scrollView.contentOffset.y)
        
        transitionImageView = UIImageView()
        transitionImageView.contentMode = UIViewContentMode.ScaleAspectFill
        transitionImageView.clipsToBounds = true
        transitionImageView.image = photoViewController.imageArray[photoViewController.currentImageIndex].image
        transitionImageView.frame.size = photoViewController.imageView.frame.size
        transitionImageView.frame.origin = photoImageViewOrigin
       

        
        var window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(transitionImageView)
        
        
        //fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            containerView.backgroundColor = UIColor(white:0, alpha:0)
            self.transitionImageView.frame.size = self.newsImageViewSize
            self.transitionImageView.frame.origin = self.newsImageViewOrigin
            }) { (finished: Bool) -> Void in
                self.transitionImageView.removeFromSuperview()
                self.finish()
                
        }
    }

}
