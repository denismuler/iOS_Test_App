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
    var lastSelectedId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postTableViewCell")
        
        Networking.shared.delegate = self
        Networking.shared.fetchPostsList()
    }
    
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Choose type of sorting",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Default",
                                      style: .default,
                                      handler: {_ in
            self.posts = self.posts.sorted(by: { $0.postId < $1.postId })
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Date",
                                      style: .default,
                                      handler: {_ in
            self.posts = self.posts.sorted(by: { $0.timeshamp > $1.timeshamp })
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Rating",
                                      style: .default,
                                      handler: { _ in
            self.posts = self.posts.sorted(by: { $0.likes_count > $1.likes_count })
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postSegue" {
            if let destVC = segue.destination as? PostDetailViewController {
                destVC.id = lastSelectedId
            }
        }
    }
}
// MARK: - UITableViewDelegate & UITableViewDataSource
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! PostTableViewCell
      cell.delegate = self

        cell.post = posts[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    private func tableView(tableView: UITableView,
                           heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lastSelectedId = posts[indexPath.row].postId
        performSegue(withIdentifier: "postSegue", sender: nil)
    }
}
// MARK: - NetworkingDelegate
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
// MARK: - PostTableViewCellDelegate
extension PostViewController: PostTableViewCellDelegate {
    func expandTap() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
