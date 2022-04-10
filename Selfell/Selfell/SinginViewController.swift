//
//  SinginViewController.swift
//  Selfell
//
//  Created by Hasan Tekbaş on 4.03.2022.
//

import UIKit
import Firebase

class SinginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfig: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CircleBack.layer.cornerRadius = 50
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Sumbitt(_ sender: Any) {
        if email.text != "" && password.text != "" {
                    Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authdata, error) in
                        
                        if error != nil {
                            self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                        } else {
                            self.performSegue(withIdentifier: "toSecondView", sender: nil)
                        }
                    }
                } else {
                    makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
                }
    }
    @IBOutlet weak var CircleBack: UIImageView!
    
    
    func makeAlert(titleInput:String, messageInput:String) {
          let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                      let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                      alert.addAction(okButton)
                      self.present(alert, animated: true, completion: nil)
      }
      

}
