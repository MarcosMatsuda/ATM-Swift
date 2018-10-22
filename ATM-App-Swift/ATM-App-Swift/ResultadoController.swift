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
    @IBOutlet weak var tvResultados: UITextView!
    
    var _valor: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tvResultados.isEditable = false
        calculaResultado(nota: Int(valor!)!)
    }
    
    
    
    func calculaResultado(nota: Int){
        
        _valor = Int(valor!)!
        var sobra: Int = 0
        var mensagem: String = ""
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:
            "Notas")
        fetchRequest.propertiesToFetch = ["valor"]
        fetchRequest.returnsDistinctResults = true
        let sortDescriptor = NSSortDescriptor(key: "valor", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        
        do{
            let results = try context.fetch(fetchRequest)
            sobra = _valor
            
            for r in results {
                
                let nota = (r as AnyObject).value(forKey: "valor") as! Int
                
                while nota < _valor {
                    
                    mensagem += "Quantidade de notas de R$ \(nota): \(_valor / nota)x"
                    mensagem += "\r\n"
                    
                    sobra = Int(_valor % nota)
                    
                    _valor = sobra
                }
            }
            
            if sobra > 0 {
                mensagem += "Não existem notas para calcular: R$ \(sobra)"
                mensagem += "\r\n"
                mensagem +=  "Por favor adicione mais notas"
            }
            tvResultados.text = mensagem
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
    }
    
}
