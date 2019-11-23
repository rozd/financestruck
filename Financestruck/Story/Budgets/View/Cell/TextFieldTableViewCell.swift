//
//  TextFieldTableViewCell.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 23.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate: class {
    func textFieldCell(_ cell: TextFieldTableViewCell, didChangeString string: String?)
    func textFieldCellDidBeginEditing(_ cell: TextFieldTableViewCell)
}

class TextFieldTableViewCell: UITableViewCell {

    // MARK: Outlets

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }

    // MARK: Delegate

    weak var delegate: TextFieldTableViewCellDelegate?

    // MARK: Cell lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: Actions
    
    @IBAction func handleTextFieldChange(_ sender: Any) {
        self.delegate?.textFieldCell(self, didChangeString: textField.text)
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldTableViewCell: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.textFieldCellDidBeginEditing(self)
    }

}
