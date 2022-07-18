//
//  TableViewCell.swift
//  iOS_TestApp
//
//  Created by Georgie Muler on 17.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textButton: UIButton!
    
    var post: Posts? {
        didSet {
            guard let post = post else {
                return
            }
            titleLabel.text = post.title
            previewLabel.text = post.preview_text
            likesLabel.text = String(post.likes_count)

            titleLabel.sizeToFit()
            titleLabel.numberOfLines = 1
            previewLabel.sizeToFit()
            
            if textButton.isSelected == false {
                previewLabel.numberOfLines = 2
            } else if textButton.isSelected == true {
                previewLabel.numberOfLines = 0
                print("gggg")
                textButton.setTitle("FGGH", for: .normal)
            }
        }
    }
}
