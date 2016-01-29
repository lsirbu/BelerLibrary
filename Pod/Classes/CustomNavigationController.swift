//
//  CustomNavigationController.swift
//  MyFramework
//
//  Created by Liliana on 25/01/16.
//  Copyright (c) 2016 Liliana Sirbu. All rights reserved.
//

import UIKit

public class CustomNavigationController:UINavigationController, UINavigationControllerDelegate{
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup(){
        self.delegate = self
    }
    
    public func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if let navBar = self.customNavigationBar(){
            navBar.updateTitleView()
        }
    }
    
    public func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool){
        
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}



// MARK: CustomNavigationBar Extension

public extension UINavigationController{
    
    // Return the customNavigationBar object, if it exists.
    public func customNavigationBar()->CustomNavigationBar?{
        if let navbar = self.navigationBar as? CustomNavigationBar{
            return navbar
        }
        else{
            return nil
        }
    }
    
    // Set the CustomNavigationBar as delegate for a UIScrollView
    public func setupPulltoRefresh(scrollView:UIScrollView, viewController: CustomNavigationBarDelegate?){
        if let navbar = self.customNavigationBar(){
            scrollView.delegate = navbar
            navbar.delegateNav = viewController
        }
    }
    
    public func stopRefresh(){
        if let navbar = self.customNavigationBar(){
            navbar.stopLoaderAnimation()
        }
    }
    
}