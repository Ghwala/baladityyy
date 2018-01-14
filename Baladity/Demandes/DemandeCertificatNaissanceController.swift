//
//  DemandeCertificatNaissanceController.swift
//  Baladity
//
//  Created by utilisateur on 30/11/2017.
//  Copyright © 2017 Esprit. All rights reserved.
//

import UIKit

class DemandeCertificatNaissanceController: UIViewController , UIDocumentInteractionControllerDelegate{
    
    var docController:UIDocumentInteractionController!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var nom: UITextField!
    
    @IBOutlet weak var prenom: UITextField!
    
    @IBOutlet weak var dateNaissance: UITextField!
    
    @IBOutlet weak var prenomPere: UITextField!
    
    @IBOutlet weak var prenomMere: UITextField!
    var str:String!
    
    var mess:String?
    var todoTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("heeelooo")
        
        let pdfUrl = NSURL(string: "http://192.168.1.143/projetmobile/baladity/script/x"+nom.text!+prenom.text!+".pdf")
        // downloadDoc(pdfUrl: pdfUrl!)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func afficher(_ sender: Any) {
        
    }
    
    
    
    @IBAction func DemandeCertifNaissance(_ sender: Any) {
        
        
        /* var request = URLRequest(url: URL(string: "http://172.19.9.13/projetmobile/baladity/script/demandecertifnaissance.php")! as URL)
         request.httpMethod = "POST"
         
         let postString = "nom=\(nom.text!)&prenom=\(prenom.text!)&dateDeNaissance=\(dateNaissance.text!)&pere=\(prenomPere.text!)&mere=\(prenomMere.text!)"
         
         request.httpBody = postString.data(using: String.Encoding.utf8)
         
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         
         if error != nil {
         print ("error=\(String(describing: error))")
         
         return
         }
         do {
         let responseData = data
         
         let todo = try JSONSerialization.jsonObject(with: responseData!, options: []) as? [String: AnyObject]
         
         self.todoTitle = todo?["error"] as? String
         
         print("The title is: " + self.todoTitle!)
         
         self.mess = todo?["message"] as? String
         if(self.todoTitle=="success")
         {print("ssssssss")
         
         var requestcvt = URLRequest(url: URL(string: "http://172.19.9.13/projetmobile/baladity/script/cvt.php")! as URL)
         requestcvt.httpMethod = "POST"
         
         let postString = "nom=\(self.nom.text!)&prenom=\(self.prenom.text!)&dateDeNaissance=\(self.dateNaissance.text!)&pere=\(self.prenomPere.text!)&mere=\(self.prenomMere.text!)"
         
         // request.httpBody = postString.data(using: String.Encoding.utf8)
         
         requestcvt.httpBody = postString.data(using: String.Encoding.utf8)
         let taskcvt = URLSession.shared.dataTask(with: requestcvt) { (data, response, error) in
         
         if error != nil {
         print ("error=\(String(describing: error))")
         
         return
         }
         
         }
         taskcvt.resume()
         
         }
         
         } catch  {
         print("error trying to convert data to JSON")
         return
         }
         
         }
         task.resume()
         if(self.todoTitle=="success")
         {
         self.docController.presentOptionsMenu(from: self.view.frame, in: self.view, animated: true)
         }
         else{
         let alert = UIAlertController(title: todoTitle , message: mess , preferredStyle:  UIAlertControllerStyle.alert)
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
         
         /* let req = NSURLRequest(url: URL(string: "http://172.20.10.4/baladity/script/index.pdf")!)
         let webView = UIWebView(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height: self.view.frame.size.height-40)) //Adjust view area here
         webView.loadRequest(req as URLRequest)
         self.view.addSubview(webView)
         
         */
         
         //print(self.str)
         
         
         */
        
        
        
        
        
        let url = URL(string: "http://192.168.1.105/projetmobile/baladity/script/demandecertif.php")!
        var request = URLRequest(url: url)
        // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "nom=\(self.nom.text!)&prenom=\(self.prenom.text!)&dateDeNaissance=\(self.dateNaissance.text!)&pere=\(self.prenomPere.text!)&mere=\(self.prenomMere.text!)"
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
            let alert = UIAlertController(title: "cartificat de naissance", message: "votre demande a été déposer avec succée", preferredStyle:  UIAlertControllerStyle.alert)
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
        nom.text = ""
        prenom.text = ""
        dateNaissance.text = ""
        prenomPere.text = ""
        prenomMere.text = ""
        
        // }
    }
    /*func downloadDoc(pdfUrl: NSURL) {
     let urlTest = pdfUrl.absoluteString
     let pdfUrl = NSURL(string: urlTest!)
     if(pdfUrl != nil){
     let pdfRequest: NSURLRequest = NSURLRequest(url: pdfUrl! as URL)
     NSURLConnection.sendAsynchronousRequest(pdfRequest as URLRequest, queue: OperationQueue.main) {(response, data, error) in
     let httpResponse = response as? HTTPURLResponse
     if(httpResponse?.statusCode == 200 && error == nil){
     let documentsUrl =  FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first! as NSURL
     
     if let fileName = pdfUrl!.lastPathComponent {
     let destinationUrl = documentsUrl.appendingPathComponent(fileName)
     if let data = data {
     do {
     try data.write(to: destinationUrl!, options: .atomic)
     } catch {
     print(error)
     }
     self.docController = UIDocumentInteractionController(url: destinationUrl!)
     }
     }
     
     }
     
     }
     
     }
     */
    
    //  }
    
    
}



