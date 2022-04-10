//
//  ViewController.swift
//  Selfell
//
//  Created by Hasan Tekbaş on 1.03.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var CircleBack: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        CircleBack.layer.cornerRadius = 50
        
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        if Username.text != "" && password.text != "" {
                    Auth.auth().createUser(withEmail: Username.text!, password: password.text!) { (authdata, error) in
                        
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
    
    @IBAction func singin(_ sender: Any) { performSegue(withIdentifier: "toSinginView", sender: nil)
    }
    
   
       
    
   
        
    
    
    func makeAlert(titleInput:String, messageInput:String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                       let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                       alert.addAction(okButton)
                       self.present(alert, animated: true, completion: nil)
       }
    
    
    
}
    

