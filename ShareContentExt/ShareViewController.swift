//
//  ShareViewController.swift
//  ShareContentExt
//
//  Created by Yudiz on 1/30/17.
//  Copyright © 2017 Yudiz. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem{
            for ele in item.attachments!{
                let itemProvider = ele as! NSItemProvider
                
                if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg"){
                    itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: nil, completionHandler: { (item, error) in

                        do {
                            var imgData: Data!
                            if let url = item as? URL{
                                imgData = try Data(contentsOf: url)
                            }
                            
                            if let img = item as? UIImage{
                                imgData = UIImagePNGRepresentation(img)
                            }
                            
                            let dict: [String : Any] = ["imgData" :  imgData, "name" : self.contentText]
                            let userDefault = UserDefaults(suiteName: "group.yudiz.shareKitDemo")
                            userDefault?.set(dict, forKey: "img")
                            userDefault?.synchronize()
                        }catch let err{
                            print(err)
                        }
                    })
                }
            }
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
