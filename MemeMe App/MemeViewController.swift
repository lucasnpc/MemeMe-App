//
//  ViewController.swift
//  MemeMe App
//
//  Created by Lucas Lopes on 26/12/23.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate, UITextFieldDelegate {    

    @IBOutlet weak var pickerAlbum: UIImageView!
    @IBOutlet weak var pickerCamera: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        pickerCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            pickerAlbum.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func prepareTextFields(){
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .strokeWidth : -2.0,
            .font : UIFont(name: "Impact", size: 20)!
        ]
        topTextField.defaultTextAttributes = strokeTextAttributes
        bottomTextField.defaultTextAttributes = strokeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    @IBAction func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: pickerAlbum.image!, memedImage: generateMemedImage())
        
        AppDelegate.memes.append(meme)
        
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }
    
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        toolbar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolbar.isHidden = false
        
        return memedImage
    }
}

