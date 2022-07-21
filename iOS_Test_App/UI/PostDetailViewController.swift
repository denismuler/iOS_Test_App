//
//  PostDetailViewController.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 18.07.2022.
//

import UIKit

class PostDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var id: Int! {
        didSet {
            guard let id = id else {
                return
            }
            Networking.shared.getPost(id: id) { result in
                switch result {
                case .success(let post):
                    self.post = post
                case .failure(let error):
                    let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
                        guard let self = self else {
                            return
                        }
                        self.dismiss(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
                                    
            }
        }
    }
    
    var post: DetailPost? {
        didSet {
            guard let post = post else {
                return
            }
            
            DispatchQueue.main.async {
                self.previewLabel.text = post.text
                self.previewLabel.sizeToFit()
                self.dateLabel?.text = post.timeshamp.timeshampToDateString()
                self.likesLabel?.text = String(post.likes_count)
                self.titleLabel?.text = post.title
                self.imageView.loadFrom(URLAddress: post.postImage!)
            }
        }
    }
}
