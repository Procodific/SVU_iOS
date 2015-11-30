//
//  EntradaBitacoraViewController.swift
//  SVU
//
//  Created by Eric García on 25/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit

class EntradaBitacoraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var incidente: UITextField!
    @IBOutlet weak var lugar: UITextField!
    @IBOutlet weak var descripcion: UITextView!
    
    var addEntradaFunc:((incidente:String, lugar:String)->())!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEntrada(sender: AnyObject) {
        RestApiManager.sharedInstance.addReporte(incidente.text!, tipo: "1", descripcion: descripcion.text!, imagen: "imagen", onCompletion: {
            json in
            dispatch_async(dispatch_get_main_queue()) {
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }
    
    @IBAction func photoButtonClicked(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //
    }
}
