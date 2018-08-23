//
//  ViewController.swift
//  movies
//
//  Created by ミップ on 2018/08/21.
//  Copyright © 2018年 株式会社ミップ. All rights reserved.
//

import UIKit
import Spring

class ViewController: UIViewController {
    @IBOutlet weak var imgArea: SpringImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var textLabel: CBAutoScrollLabel!
    
    var timer: Timer?
    var imag:UIImage!
    var timer_sec: Float = 0
    var dspimgNo = 0
    let imgAryname = ["1.jpg","2.jpg","3.jpg","4.jpg"]

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
        // default表示
        if imag == nil {
            //AutScroll
            textLabel.text = "１番目の写真はごえもんくん5歳です"
            textLabel.labelSpacing = 50;                          // 開始と終了の間間隔
            textLabel.pauseInterval = 1;                          // スクロール前の一時停止時間
            textLabel.scrollSpeed = 100.0;                        // スクロール速度
            textLabel.fadeLength = 20.0;                          // 左端と右端のフェードの長さ
            textLabel.font = UIFont.systemFont(ofSize: 25.0)      // フォント設定
            let defimg = UIImage(named: imgAryname[0])
            imgArea.image = defimg
        }
        else{
            imgArea.image = imag
        }
        //スライド
        if self.timer == nil {
            self.timer_sec = 0
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        
        //imgArea.animation = "fadeInLeft"
        //imgArea.duration = 1.0
        //imgArea.animate()
        if dspimgNo < 0 {
            dspimgNo = 3
        }
        if dspimgNo > 3 {
            dspimgNo = 0
        }
        let name = imgAryname[dspimgNo]
        let img  = UIImage(named: name)
        imgArea.image = img
        

        
        switch dspimgNo {
        case 0 :
            self.textLabel.text = "１番目の写真はごえもんくん5歳です１番目の写真はごえもんくん5歳です"
        case 1 :
            self.textLabel.text = "2番目の写真もごえもんくんです2番目の写真もごえもんくんです2番目の写真もごえもんくんです"
        case 2 :
            self.textLabel.text = "3番目の写真もごえもんくんです"
        case 3 :
            self.textLabel.text = "4番目の写真もごえもんくんです"
        default:
            self.textLabel.text = "１番目の写真はごえもんくん5歳です"
      
        }
        //AutScroll
        textLabel.labelSpacing = 50;                          // 開始と終了の間間隔
        textLabel.pauseInterval = 1;                          // スクロール前の一時停止時間
        textLabel.scrollSpeed = 100.0;                         // スクロール速度
        textLabel.fadeLength = 20.0;                          // 左端と右端のフェードの長さ
        textLabel.font = UIFont.systemFont(ofSize: 25.0)      // フォント設定
    }

    //----------------------------------------
    
    @objc func updateTimer(timer: Timer){
        self.timer_sec += 5.0
        self.timerLabel.text = String(format: "%.1f", timer_sec)
        upimgNo()
        viewImage()
    }
}

