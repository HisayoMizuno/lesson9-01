//
//  ViewController.swift
//  movies
//
//  Created by ミップ on 2018/08/21.
//  Copyright © 2018年 株式会社ミップ. All rights reserved.
//

import UIKit
import Foundation
import Spring

class ViewController: UIViewController {
    @IBOutlet weak var imgArea: SpringImageView!
    @IBOutlet weak var boxView: SpringView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    
    var timer: Timer?
    var timer_text: Timer?
    var imag:UIImage!
    var dspimgNo = 0
    let imgAryname = ["0.JPG","1.JPG","2.JPG","3.JPG"]
    var strtext: String = ""
    var strcount = 0
    var idx = 0
    var flgstr = false
    var timer_sec: Float = 0
    var text_timer_sec: Float = 0
    var imag_timer_sec: Float = 0

    //-----------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
  
    //-----------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //-----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        imgArea.animation = "zoomIn"
        imgArea.duration = 5
        imgArea.alpha = 2.0
        imgArea.delay = 1
        imgArea.animate()
         
        boxView.animation = "slideLeft"
        boxView.duration = 5
        boxView.alpha = 2.0
        boxView.delay = 3
        boxView.animate()
 
        
        // default表示
        if imag == nil {
            //textLabel.text = "１番目の写真はごえもんくん5歳です"
            //textLabel.font = UIFont.systemFont(ofSize: 25.0)      // フォント設定
            //let defimg = UIImage(named: imgAryname[0])
            //imgArea.image = defimg
            //textView()
        }
        else{
            print("bbbbbbbbbbbbbbbbbb")

            //imgArea.image = imag

        }
       */

        //スライド------------------
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer(timer:)), userInfo: nil, repeats: true)
            //self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(timer_sec + 5.0), target: self, selector: #selector(updateTimer(timer:)), userInfo: nil, repeats: true)
        }
        else{
            self.timer?.invalidate() // タイマーを破棄
            self.timer = nil // timerをnilにする(startTimer用）
        }


    }

    //-----------------------------------------
    func upimgNo() {
        dspimgNo += 1
    }
    func dnimgNo() {
        dspimgNo -= 1
    }
    //-----------------------------------------
    func viewImage() {
        
        if dspimgNo < 0 {
            dspimgNo = 3
        }
        if dspimgNo > 3 {
            dspimgNo = 0
        }
    
        let name = imgAryname[dspimgNo]
        let img  = UIImage(named: name)
        imgArea.image = img

        
        imgArea.animation = "zoomIn"
        imgArea.duration = 5
        imgArea.alpha = 2.0
        imgArea.delay = 1
        imgArea.animate()
        
    }
    //----------------------------------------
    @objc func textView() {
        print("++++++textView入り口  dspimgNo = \(dspimgNo) idx=\(idx)")
        switch dspimgNo {
            case 1 : strtext = "１番目の写真はごえもんくん5歳です\n１番目の写真はごえもんくん5歳です"
            case 2 : strtext = "2番目の写真もごえもんくんです"
            case 3 : strtext = "3番目の写真もごえもんくんです\n3番目の写真もごえもんくんです\n3番目の写真もごえもんくんです"
            case 4 : strtext = "4番目の写真もごえもんくんです"
            default: strtext = "１番目の写真はごえもんくん5歳です"
        }
        print("***** imgno=\(dspimgNo) / strtext=\(strtext) / idx=\(idx)")

        if idx < strtext.count {
            //print("aaaaaaa \(strtext)")
            self.textLabel.text = strtext.substring(to: strtext.index(strtext.startIndex, offsetBy: idx))
            idx += 1
            text_timer_sec += 1.0
            //print("eeeeeeeeeeeeeeeeeee idx==\(idx)  / \(String(describing: textLabel.text))")
        }
        textLabel.font = UIFont.systemFont(ofSize: 25.0)        // フォント設定
    }
    //----------------------------------------
    @objc func updateTimer(timer: Timer) {


        print("⭐︎updateTime入口   strtext= \(strtext)   text_timer_sec === \(text_timer_sec)")
        
        if text_timer_sec == Float(strtext.count)  {
            viewImage()
            idx = 0
            if self.timer_text == nil {
                timer_text = Timer.scheduledTimer(timeInterval: 0.5 ,target: self, selector: #selector(textView),userInfo: nil,repeats: true)
                timer_text?.fire()
                
            }
            else{
                print("222222222222222222222222 END  === \(text_timer_sec)")
                timer_sec = text_timer_sec + timer_sec
                text_timer_sec = 0
                self.timer = nil // timerをnilにする(startTimer用）
            }
            self.timerLabel.text = String(format: "%.1f", timer_sec)
            upimgNo()
        }

        

        
    }
}

