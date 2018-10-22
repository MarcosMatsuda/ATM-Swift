//
//  ViewController.swift
//  ATM-App-Swift
//
//  Created by Marcos Matsuda on 19/10/2018.
//  Copyright © 2018 Marcos Matsuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var tfValorDesejado: UITextField!
  
    @IBAction func btCalcular(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultadoController{
            vc.valor = tfValorDesejado.text!
        }
    }
    
    
}

