//
//  TableViewCell.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteBtnRef: UIButton!
    
    var deleteClouser: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(data: HomeDataModel) {
        titleLabel.text = data.name ?? ""
    }
    
    @IBAction func deleteBtnTap(_ sender: Any) {
        deleteClouser?()
    }
}
