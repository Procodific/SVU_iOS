//
//  BitacoraTableViewController.swift
//  SVU
//
//  Created by Eric García on 25/10/15.
//  Copyright © 2015 Eric García. All rights reserved.
//

import UIKit
import EZLoadingActivity

class BitacoraTableViewController: UITableViewController {
    var incidentes = [String!]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getReportes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return incidentes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        print(incidentes[indexPath.row])
        print(incidentes[indexPath.row]!)
        
        var cadena = incidentes[indexPath.row].stringByReplacingOccurrencesOfString("Optional(\"", withString: "")
        
        cadena = cadena.stringByReplacingOccurrencesOfString("\")", withString: "")
        cell.textLabel!.text! = cadena

        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addEntrada" {
            let addEntradaViewController = segue.destinationViewController as! EntradaBitacoraViewController
            addEntradaViewController.addEntradaFunc = appendData
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        }
    
    func appendData(incidente: String, lugar: String) {
        self.incidentes.append("\(incidente), \(lugar)");
    }
    
    func getReportes() {
        
        EZLoadingActivity.Settings.SuccessText = "Listo"
        EZLoadingActivity.Settings.FailText = "Error"
        EZLoadingActivity.show("Cargando...", disableUI: false)
        
        RestApiManager.sharedInstance.getReportes { json in
            var arreglo = [String!]()
            
            for (index, object) in json {
                arreglo.append("\(object["nombre"].stringValue)")
            }
            
            self.incidentes = arreglo
            
            dispatch_async(dispatch_get_main_queue()) {
                EZLoadingActivity.hide(success: true, animated: true)
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
}
