//
//  ReaderViewController.swift
//  PDF-Demo
//
//  Created by Xiaodan Wang on 2/19/17.
//  Copyright © 2017 Xiaodan Wang. All rights reserved.
//
import UIKit

class ReaderViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var urlString:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let fileURL = URL(fileURLWithPath: self.urlString)
        let request = URLRequest(url: fileURL)
        print("hhhhhh")
        print(request)
        print(fileURL)
        self.webView.loadRequest(request)
        
    }
    
    
}

