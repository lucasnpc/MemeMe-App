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
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a bar button item with a title
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(titleAction))

        // Create a bar button item with an image
        let addMemeImageButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(imageAction))
        let font = UIFont.systemFont(ofSize: 25.0)
        addMemeImageButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = addMemeImageButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("fuck table")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        
        return cell
    }
    
    @objc func titleAction() {
        print("fuck title table ")
    }
    
    @objc func imageAction() {
        print("fuck action table")
    }
}
