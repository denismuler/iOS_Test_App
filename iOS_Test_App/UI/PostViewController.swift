//
//  ViewController.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 17.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var post: PostsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "postTableViewCell")

        Networking.shared.delegate = self
        Networking.shared.fetchPostsList()

    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! TableViewCell
        cell.post = post?.posts[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    private func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PostViewController: NetworkingDelegate {
    func showPosts(with postsList: PostsList) {
        self.post = postsList
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
//        print(postsList)
    }
}
