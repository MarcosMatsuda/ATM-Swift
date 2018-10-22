//
//  NotasTableViewCell.swift
//  ATM-App-Swift
//
//  Created by Marcos Matsuda on 22/10/2018.
//  Copyright © 2018 Marcos Matsuda. All rights reserved.
//

import UIKit

class NotasTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbNotasDisponiveis: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with nota: Notas){
        lbNotasDisponiveis.text = String(nota.valor)
    }

}
