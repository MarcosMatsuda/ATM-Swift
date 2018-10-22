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
        
        

        if tfValorDesejado.text != "" && verificaValor(nota: Int(tfValorDesejado.text!)!) {
                performSegue(withIdentifier: "segue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultadoController{
            vc.valor = tfValorDesejado.text!
        }
    }
    
    func verificaValor(nota: Int) -> Bool{
        if nota <= 0 || nota > 10000 {
            return false
        }
        return true
    }
    
    
}

