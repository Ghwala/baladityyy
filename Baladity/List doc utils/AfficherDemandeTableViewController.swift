
import UIKit
import Alamofire
import MBProgressHUD
import WebKit

class AfficherDemandeViewController: UITableViewController ,cellDelegate {
 
    
    let urlString = "http://172.16.247.103/baladityscript/AfficherListDocuments.php"

        var fileLocalURLDict = [Int:String]()
        
        
        var name = [String]()
        var pdf = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tableView.tableFooterView = UIView()
            self.title = "PDF"
            self.downloadJsonWithURL()
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return name.count
        }
        
        
        
        func downloadJsonWithURL() {
            let url = NSURL(string: urlString)
            URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                    
                    if let eventArray = jsonObj!.value(forKey: "pdfs") as? NSArray {
                        
                        print(eventArray)
                        for event in eventArray{
                            if let eventtDict = event as? NSDictionary {
                                
                                
                                if let name = eventtDict.value(forKey: "titre") {
                                    self.name.append(name as! String)
                                    print(name)
                                }
                                if let pdfurl = eventtDict.value(forKey: "pdf") {
                                    self.pdf.append(pdfurl as! String)
                                    print("urrllllll")
                                    print(pdfurl)
                                }
                                
                                
                                
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }
            }).resume()
        }
        
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemandeTableViewCell
            cell.nameLabel.text = name[indexPath.row]
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        //Mark: - custom cell delegate methods
        func didClickDownloadButton(cell: UITableViewCell) {
            let indexPath = self.tableView.indexPath(for: cell)
            print(indexPath?.row ?? "")
            
            
            if let index = indexPath?.row {
                (cell as! DemandeTableViewCell).viewButton.isEnabled = true
                downloadFileWithIndex(ind: index)
            }
            
        }
        
        func didClickViewButton(cell: UITableViewCell) {
            let indexPath = self.tableView.indexPath(for: cell)
            print(indexPath?.row ?? "")
            
            
            if let index = indexPath?.row {
                
                print()
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
                
                let urlString:String! = fileLocalURLDict[index]
                vc.urlString = urlString
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        
        
        
        func downloadFileWithIndex(ind:Int) {
            
            //--2.--//
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.annularDeterminate
            hud.label.text = "Loading..."
            //--2.--//
            
            //--1.--//
            
            let urlString = pdf[ind]
            print("kkkkk")
            print(urlString)
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                let documentsURL:NSURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
                print("***documentURL: ",documentsURL)
                let fileURL = documentsURL.appendingPathComponent("\(ind).pdf")
                print("***fileURL: ",fileURL ?? "")
                return (fileURL!,[.removePreviousFile, .createIntermediateDirectories])
            }
            
            Alamofire.download(urlString, to: destination).downloadProgress(closure: { (prog) in
                hud.progress = Float(prog.fractionCompleted)
            }).response { response in
                //print(response)
                hud.hide(animated: true)
                if response.error == nil, let filePath = response.destinationURL?.path {
                    print("mmmm",filePath)
                    self.fileLocalURLDict[ind] = filePath
                }
            }
            //--1.--//
            
        }
        
        
}

