//
//  GuardiaViewController.swift
//  SVU
//
//  Created by Eric García on 25/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit

class GuardiaViewController: UIViewController {
    
    @IBOutlet weak var numTrabajador: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var firstLaunch : Bool!
    var logged : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Logged")
        */
    
        firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        logged = NSUserDefaults.standardUserDefaults().boolForKey("Logged")
        
        if firstLaunch == false && logged == true {
            self.performSegueWithIdentifier("ingreso_guardia", sender: self)
        }
        else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstLaunch")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ingresarButtonClicked(sender: AnyObject) {
        let str_trabajador = numTrabajador.text
        let str_password = password.text
        
        if str_trabajador?.isEmpty == false && str_password?.isEmpty == false {
            if str_trabajador == "18F4550" && str_password == "pic" {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Logged")
                let alert = UIAlertController(title: "Login exitoso", message: "Guardia loggeado correctamente", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: nil))
                self.performSegueWithIdentifier("ingreso_guardia", sender: self)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Login incorrecto", message: "Los datos son incorrectos", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Faltan campos", message: "Favor de ingresar más campos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "ingreso_guardia" {
            if firstLaunch == false && logged == true {
                return true
            }
        }
        return false
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
