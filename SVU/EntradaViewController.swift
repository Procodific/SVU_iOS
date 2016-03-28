//
//  EntradaViewController.swift
//  SVU
//
//  Created by Eric García on 30/11/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit

class EntradaViewController: UIViewController {

    @IBOutlet weak var incidenteTextField: UITextField!
    @IBOutlet weak var lugarTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextView!
    
    var incidente : String!
    var lugar : String!
    var descripcion : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
