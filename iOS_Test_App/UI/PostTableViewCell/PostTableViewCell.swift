//
//  PostTableViewCell.swift
//  iOS_TestApp
//
//  Created by Georgie Muler on 17.07.2022.
//

import UIKit

protocol PostTableViewCellDelegate {
    func expandTap()
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textButton: UIButton!
    
    var isExpended: Bool = false
    var delegate: PostTableViewCellDelegate?
    
    @IBAction func textButtonPressed(_ sender: Any) {
        isExpended = !isExpended
        if isExpended {
            previewLabel.numberOfLines = 0
            textButton.setTitle("Collapse", for: .normal)
            previewLabel.sizeToFit()
        } else {
            previewLabel.numberOfLines = 2
            textButton.setTitle("Expand", for: .normal)
            previewLabel.sizeToFit()
        }
        updateLayout()
    }
    
    var post: Posts? {
        didSet {
            guard let post = post else {
                return
            }
            titleLabel.text = post.title
            previewLabel.text = post.preview_text
            likesLabel.text = String(post.likes_count)
            timeLabel.text = post.timeshamp.timeshampToDateString()
            
            titleLabel.sizeToFit()
            titleLabel.numberOfLines = 1
            
            previewLabel.sizeToFit()
            configureExpandButton()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureExpandButton() {
        guard let post = self.post else { return }
        if isExpended {
            previewLabel.numberOfLines = 0
            textButton.setTitle("Collapse", for: .normal)
        } else {
            previewLabel.numberOfLines = 2
            textButton.setTitle("Expand", for: .normal)
        }
        previewLabel.text = post.preview_text
        textButton.isHidden = checkNeededExpandButton()
    }
    
    private func checkNeededExpandButton() -> Bool {
        return previewLabel.maxNumberOfLines <= 2
    }
    
    private func updateLayout() {
        setNeedsLayout()
        layoutSubviews()
        layoutIfNeeded()
        delegate?.expandTap()
    }
}
