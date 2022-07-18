//
//  ViewController.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 17.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postTableViewCell")

        Networking.shared.delegate = self
        Networking.shared.fetchPostsList()
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! PostTableViewCell
        cell.post = posts[indexPath.row]
      cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PostViewController: NetworkingDelegate {
    func showPosts(with posts: [Posts]) {
        self.posts = posts
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
    }
}

extension PostViewController: PostTableViewCellDelegate {
  func expandTap() {
    tableView.beginUpdates()
    tableView.endUpdates()
  }
}
