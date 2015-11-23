//
//  ViewController.swift
//  SVU
//
//  Created by Eric García on 12/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit

class AlumnoViewController: UIViewController {

    @IBOutlet weak var matricula: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var firstLaunch : Bool!
    var registered : Bool!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Registered")
        */
        
        firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        registered = NSUserDefaults.standardUserDefaults().boolForKey("Registered")
        
        if firstLaunch == false && registered == true {
            print("Ya está registrado y no es primera vez que arranca");
            self.performSegueWithIdentifier("ingreso_alumno", sender: self)
        }
        else {
            print("Registrate")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstLaunch")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registroButtonClicked(sender: AnyObject) {
        let str_matricula = matricula.text
        let str_password = password.text
        
        print("Matrícula: \(str_matricula), Contraseña: \(str_password)")
        
        if str_matricula?.isEmpty == false && str_password?.isEmpty == false {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Registered")
            self.performSegueWithIdentifier("ingreso_alumno", sender: self)
            let alert = UIAlertController(title: "Registro exitoso", message: "Usuario registrado correctamente", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Faltan campos", message: "Favor de ingresar más campos", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "ingreso_alumno" {
            if firstLaunch == false && registered == true {
                return true
            }
        }
        return false
    }

}

