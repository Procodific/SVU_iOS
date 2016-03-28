//
//  GuardiaViewController.swift
//  SVU
//
//  Created by Eric García on 25/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit
import EZLoadingActivity

class GuardiaViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var numTrabajador: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var activeField: UITextField!;
    var firstLaunch : Bool!
    var logged : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numTrabajador.delegate = self
        self.password.delegate = self
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Logged")
        
        firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        logged = NSUserDefaults.standardUserDefaults().boolForKey("Logged")
        
        if firstLaunch == false && logged == true {
            self.performSegueWithIdentifier("ingreso_guardia", sender: self)
        }
        else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstLaunch")
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ingresarButtonClicked(sender: AnyObject) {
        let str_trabajador = numTrabajador.text
        let str_password = password.text
        
        EZLoadingActivity.Settings.SuccessText = "Bienvenido"
        EZLoadingActivity.Settings.FailText = "Error"
        EZLoadingActivity.show("Ingresando...", disableUI: false)
        
        var error_campos = false
        var error_datos = false
        
        let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        
        dispatch_async(backgroundQueue, {
            if str_trabajador?.isEmpty == true || str_password?.isEmpty == true {
                error_campos = true
            }
            else {
                if str_trabajador != "18F4550" || str_password != "pic" {
                    error_datos = true
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error_campos == false && error_datos == false {
                    EZLoadingActivity.hide(success: true, animated: true)
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Logged")
                    
                    NSNotificationCenter.defaultCenter().removeObserver(self)
                    
                    self.performSegueWithIdentifier("ingreso_guardia", sender: self)
                }
                else {
                    EZLoadingActivity.hide(success: false, animated: true)
                    if error_campos {
                        let alert = UIAlertController(title: nil, message: "Favor de ingresar más campos", preferredStyle: UIAlertControllerStyle.Alert)
                        self.presentViewController(alert, animated: true, completion: nil)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: nil, message: "Los datos son incorrectos", preferredStyle: UIAlertControllerStyle.Alert)
                        self.presentViewController(alert, animated: true, completion: nil)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            })
        })

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "ingreso_guardia" {
            if firstLaunch == false && logged == true {
                return true
            }
        }
        return false
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeField = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.numTrabajador {
            self.password.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    // Call this method somewhere in your view controller setup code.
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    // Called when the UIKeyboardDidShowNotification is sent.
    
    func keyboardWasShown(aNotification: NSNotification) {
        var info: [NSObject : AnyObject] = aNotification.userInfo!
        let kbSize: CGSize = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
        if !CGRectContainsPoint(aRect, activeField.frame.origin) {
            self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    // Called when the UIKeyboardWillHideNotification is sent
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
