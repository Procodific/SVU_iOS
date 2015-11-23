//
//  EntradaBitacoraViewController.swift
//  SVU
//
//  Created by Eric García on 25/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit

class EntradaBitacoraViewController: UIViewController {

    @IBOutlet weak var incidente: UITextField!
    @IBOutlet weak var lugar: UITextField!
    @IBOutlet weak var descripcion: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "entrada_bitacora" {
            
            let str_incidente = incidente.text
            let str_lugar = lugar.text
            let str_descripcion = descripcion.text
            
            if str_incidente?.isEmpty == false && str_lugar?.isEmpty == false && str_descripcion?.isEmpty == false {
                print("agregadno")
                let destinationController = segue.destinationViewController as!BitacoraTableViewController
                
                destinationController.incidentes.append("\(str_incidente), \(str_lugar)")
                print(destinationController.incidentes.count)
            }
            else {
                
            }
        }
    }

}
