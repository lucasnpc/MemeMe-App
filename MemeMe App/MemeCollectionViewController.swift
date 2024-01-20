//
//  MemeCollectionViewController.swift
//  MemeMe App
//
//  Created by Lucas Lopes on 28/12/23.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    var memes: [Meme]! {
        return AppDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a bar button item with a title
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))

        // Create a bar button item with an image
        let addMemeImageButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addAction))
        let font = UIFont.systemFont(ofSize: 25.0)
        addMemeImageButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        navigationItem.setLeftBarButton(editButton, animated: true)
        navigationItem.setRightBarButton(addMemeImageButton, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memedImage?.image = meme.memedImage
        
        return cell
    }
    
    @objc func editAction() {
        print("edit collection")
    }
    
    @objc func addAction() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}

