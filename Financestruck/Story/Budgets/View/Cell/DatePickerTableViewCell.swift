//
//  DatePickerTableViewCell.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 20.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

protocol DatePickerTableViewCellDelegate: class {
    func datePickerCell(_ cell: DatePickerTableViewCell, didChangeDate date: Date)
}

class DatePickerTableViewCell: UITableViewCell {

    // MARK: Outlets

    @IBOutlet fileprivate weak var datePicker: UIDatePicker!

    // MARK: Delegate

    weak var delegate: DatePickerTableViewCellDelegate?

    // MARK: Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: Actions
    
    @IBAction func handleDatePickerChange(_ sender: Any) {
        self.delegate?.datePickerCell(self, didChangeDate: datePicker.date)
    }

}
