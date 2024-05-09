//
//  DetailViewController.swift
//  Petitions
//
//  Created by Zehra Coşkun on 7.05.2024.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

       override func loadView() {
           webView = WKWebView()
           view = webView
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                            target: self,
                                                            action: #selector(creditAction))
    
    
  

        // Do any additional setup after loading the view.
    }
    
    @objc func creditAction(){
        let ac = UIAlertController(title: "Credits", 
                                   message: "Data comes from the We The People API of the Whitehouse.",
                                   preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
   

}
