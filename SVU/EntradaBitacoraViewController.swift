//
//  EntradaBitacoraViewController.swift
//  SVU
//
//  Created by Eric García on 25/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit
import EZLoadingActivity

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
        let str_incidente = incidente.text
        let str_lugar = lugar.text
        let str_descripcion = descripcion.text
        
        EZLoadingActivity.Settings.SuccessText = "Guardado"
        EZLoadingActivity.Settings.FailText = "Error"
        EZLoadingActivity.show("Subiendo...", disableUI: false)
        
        var error_campos = false
        
        let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        dispatch_async(backgroundQueue, {
            if str_incidente?.isEmpty == true || str_lugar?.isEmpty == true || str_descripcion.isEmpty == true {
                error_campos = true
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error_campos == false {
                    RestApiManager.sharedInstance.addReporte(self.incidente.text!, tipo: "1", descripcion: self.descripcion.text!, imagen: "imagen", onCompletion: {
                        json in
                        dispatch_async(dispatch_get_main_queue()) {
                            EZLoadingActivity.hide(success: true, animated: true)
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    })
                }
                else {
                    EZLoadingActivity.hide(success: false, animated: true)
                    let alert = UIAlertController(title: nil, message: "Ingrese todos los campos", preferredStyle: UIAlertControllerStyle.Alert)
                    self.presentViewController(alert, animated: true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
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
