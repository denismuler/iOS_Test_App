//
//  PostDetailViewController.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 18.07.2022.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var post: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

