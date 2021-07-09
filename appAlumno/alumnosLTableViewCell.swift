//
//  alumnosLTableViewCell.swift
//  appAlumno
//
//  Created by Mac19 on 08/07/21.
//

import UIKit

class alumnosLTableViewCell: UITableViewCell {

    @IBOutlet weak var fotoA: UIImageView!
    
    @IBOutlet weak var nombreL: UILabel!
    @IBOutlet weak var controlL: UILabel!
    @IBOutlet weak var caliL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
