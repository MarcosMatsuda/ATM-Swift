//
//  ResultadoController.swift
//  ATM-App-Swift
//
//  Created by Marcos Matsuda on 22/10/2018.
//  Copyright © 2018 Marcos Matsuda. All rights reserved.
//

import UIKit
import CoreData

class ResultadoController: UIViewController {
    var valor: String? = nil
    
    @IBOutlet weak var tvResultado: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tvResultado.text = valor
        calculaResultado(nota: Int(valor!)!)
    }
    
    func calculaResultado(nota: Int){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:
            "Notas")
        fetchRequest.propertiesToFetch = ["valor"]
        fetchRequest.returnsDistinctResults = true
        let sortDescriptor = NSSortDescriptor(key: "valor", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for r in results {
                
                let p = (r as AnyObject).value(forKey: "valor") as! Int
                
                print(p)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
    }
    
}
