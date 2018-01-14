//
//  actedeDecesController.swift
//  Baladity
//
//  Created by utilisateur on 30/11/2017.
//  Copyright © 2017 Esprit. All rights reserved.
//

import UIKit

class actedeDecesController: UIViewController {
    
    @IBOutlet weak var nomText: UITextField!
    
    @IBOutlet weak var prenomText: UITextField!
    
    @IBOutlet weak var dateDecesText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AjouterActeDeces(_ sender: Any) {
        let url = URL(string: "http://192.168.1.143/projetmobile/baladity/script/addActeDeces.php")!
        var request = URLRequest(url: url)
        // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "nom=\(self.nomText.text!)&prenom=\(self.prenomText.text!)&dateDeces=\(self.dateDecesText.text!)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            //self.docController.presentOptionsMenu(from: self.view.frame, in: self.view, animated: true)
            print(postString)
            let alert = UIAlertController(title: "Acte de decés", message: "votre demande a été déposer avec succée", preferredStyle:  UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            {
                () -> Void in
            }
            
            
            
        }
        task.resume()
        nomText.text = ""
        prenomText.text = ""
        dateDecesText.text = ""
        
    }
}
