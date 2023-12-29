//
//  MemeTableViewController.swift
//  MemeMe App
//
//  Created by Lucas Lopes on 28/12/23.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme]! {
        return AppDelegate.memes
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a bar button item with a title
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))

        // Create a bar button item with an image
        let addMemeImageButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addAction))
        let font = UIFont.systemFont(ofSize: 25.0)
        addMemeImageButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = addMemeImageButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        
        return cell
    }
    
    @objc func editAction() {
        print("fuck title collection")
    }
    
    @objc func addAction() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}
