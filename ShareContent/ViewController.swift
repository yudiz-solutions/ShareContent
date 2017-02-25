//
//  ViewController.swift
//  ShareContent
//
//  Created by Yudiz on 1/30/17.
//  Copyright © 2017 Yudiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefault = UserDefaults(suiteName: "group.yudiz.shareKitDemo")

        if let dict = userDefault?.value(forKey: "img") as? NSDictionary{
            
            let data = dict.value(forKey: "imgData") as! Data
            let str = dict.value(forKey: "name") as! String
            
            self.imgView.image = UIImage(data: data)
            self.lblText.text = str
            
            userDefault?.removeObject(forKey: "img")
            userDefault?.synchronize()
        }
    }
}

