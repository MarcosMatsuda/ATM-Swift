//
//  NotaViewController.swift
//  ATM-App-Swift
//
//  Created by Marcos Matsuda on 22/10/2018.
//  Copyright © 2018 Marcos Matsuda. All rights reserved.
//

import UIKit

class NotaViewController: UIViewController {

    @IBOutlet weak var tfNota: UITextField!
    @IBOutlet weak var lbMensagemErro: UILabel!
    
    var nota: Notas!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbMensagemErro.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nota = Notas(context: context)
    }
    
    
    @IBAction func addNota(_ sender: Any) {
        
        
        nota = Notas(context: context)
        
        
        if let valor = Int(tfNota.text!) {
            nota.valor = Int64(valor)
        }
        
        do {
            try context.save()
            tfNota.text = ""
            lbMensagemErro.text = ""
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    

}
