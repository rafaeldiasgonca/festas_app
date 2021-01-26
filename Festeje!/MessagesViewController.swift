//
//  MessagesViewController.swift
//  Festeje!
//
//  Created by Vinícius Pinheiro on 25/01/21.
//  Copyright © 2021 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    let imageNames = ["cake", "curious", "soda", "inphone"]
    var stickers = [MSSticker]()
    @IBOutlet weak var browser: MSStickerBrowserView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for imageName in imageNames {
            if let url = Bundle.main.url(forResource: imageName, withExtension: "png") {
                do {
                    let sticker = try MSSticker(contentsOfFileURL: url, localizedDescription: "\(imageName)_sticker")
                    stickers.append(sticker)
                } catch {
                    print("error!")
                }
                
            }
        }
        
        browser.dataSource = self
    }
    
}

extension MessagesViewController: MSStickerBrowserViewDataSource {
    func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }
    
    func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }
    
    
}
