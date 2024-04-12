//
//  MusicPlayerTableViewController.swift
//  SuperJunior
//
//  Created by 凱聿蔡凱聿 on 2023/10/19.
//

import UIKit
import SpriteKit
import AVFoundation

enum PlayMode{
    case play
    case pause
}
class MusicPlayerTableViewController: UIViewController {
    
    @IBOutlet var musicView: UIView!
    @IBOutlet weak var musicImageView: CDImage!
    @IBOutlet weak var musicbackimageView: UIImageView!
    @IBOutlet weak var musicimagebackView: UIView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var playButtion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.formatWidth = 2
        numberFormatter.paddingCharacter = "0"
        
        musicimagebackView.layer.cornerRadius = 150
        musicimagebackView.layer.shadowColor = UIColor.black.cgColor
        musicimagebackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        musicimagebackView.layer.shadowOpacity = 0.5
        let centerX = musicimagebackView.bounds.width / 2  
        let centerY = musicimagebackView.bounds.height / 2
        musicimagebackView.center = CGPoint(x: centerX, y: centerY)
        
        makeProgressCircle(percentage: 0)
        
        loadMusicInformation(Index: dataIndex)
        
        self.musicImageView.rotate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.musicImageView.rotate()
    }
    var player = AVPlayer()
    var numberFormatter = NumberFormatter()
    var isPlaying = false
    var timer:Timer?
    var dataIndex = 0
    let dataArray:[SongData] = [
        SongData(singer: "SuperJunior", songName: "sorry,sorry", duration: 231),
        SongData(singer: "SuperJunior", songName: "Miracle", duration: 176),
        SongData(singer: "SuperJunior", songName: "Angel", duration: 238),
        SongData(singer: "SuperJunior", songName: "It's You", duration: 231),
        SongData(singer: "SuperJunior", songName: "Super Girl", duration: 245),
        SongData(singer: "SuperJunior", songName: "U", duration: 226)
    ]
    
    @IBAction func playAndPause(_ sender: UIButton) {
        if isPlaying == false{
            executePlayOrPause(mode: .play, Index: dataIndex)
        }else{
            executePlayOrPause(mode: .pause, Index: dataIndex)
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        if dataIndex < 4{
            dataIndex += 1
            loadMusicInformation(Index: dataIndex)
            executePlayOrPause(mode: .play, Index: dataIndex)
        }else{
            dataIndex = 0
            loadMusicInformation(Index: dataIndex)
            executePlayOrPause(mode: .play, Index: dataIndex)
        }
    }
    

    @IBAction func back(_ sender: UIButton) {
        if dataIndex > 0{
            dataIndex -= 1
            loadMusicInformation(Index: dataIndex)
            executePlayOrPause(mode: .play, Index: dataIndex)
        }else{
            dataIndex = 4
            loadMusicInformation(Index: dataIndex)
            executePlayOrPause(mode: .play, Index: dataIndex)
        }
    }
    @IBAction func setVolume(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    ///
    /// - Parme : percentage ;
    func makeProgressCircle(percentage:CGFloat){
        
        let degree = CGFloat.pi/180
        let startDegree:CGFloat = 270
        let lineWidth:CGFloat = 10
        let radius:CGFloat = 170
        let center:CGPoint = CGPoint(x: 207, y: 225)
        
        let progressBackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: degree*0, endAngle: degree*360, clockwise: true)
        let progressBackLayer = CAShapeLayer()
        progressBackLayer.path = progressBackPath.cgPath
        progressBackLayer.fillColor = UIColor.clear.cgColor
        progressBackLayer.strokeColor = UIColor.lightGray.cgColor
        progressBackLayer.lineWidth = lineWidth
        musicView.layer.addSublayer(progressBackLayer)
        
        
        let centerCircle = UIBezierPath(arcCenter: center, radius: 30, startAngle: degree*0, endAngle: degree*360, clockwise: true)
        let centerLayer = CAShapeLayer()
        centerLayer.path = centerCircle.cgPath
        centerLayer.fillColor = UIColor.white.cgColor
        musicView.layer.addSublayer(centerLayer)
        
        
        
        let endDegree = startDegree+(360*percentage)
        let progressLinePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: degree*startDegree, endAngle: degree*endDegree, clockwise: true)
        let progressLayer = CAShapeLayer()
        progressLayer.path = progressLinePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.systemPink.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        musicView.layer.addSublayer(progressLayer)
        
        
        remainLabel.center = center
        musicView.addSubview(remainLabel)
    }
    
    
    func loadMusicInformation(Index:Int){
        musicImageView.image = UIImage(named: dataArray[Index].songName)
        musicbackimageView.image =  UIImage(named: dataArray[Index].songName)
        singerLabel.text = "\(dataArray[Index].singer)"
        songLabel.text = "\(dataArray[Index].songName)"
        if let url = Bundle.main.url(forResource: dataArray[Index].songName, withExtension: ".mp3"){
            player = AVPlayer(url: url)
            player.volume = 2.5
        }
    }
    
    
    func executePlayOrPause(mode: PlayMode, Index: Int) {
        switch mode {
        case .play:
            player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(musicTime), userInfo: nil, repeats: true)
            playButtion.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            isPlaying = true
        case .pause:
            player.pause()
            timer?.invalidate()
            playButtion.setImage(UIImage(systemName: "play.fill"), for: .normal)
            isPlaying = false
        }
    }
    
    
    @objc func musicTime(){
        
        let progressPercent = CGFloat(player.currentTime().seconds/Double(dataArray[dataIndex].duration))
        makeProgressCircle(percentage: progressPercent)
        let remainMinuteText = numberFormatter.string(from: NSNumber(value: Int(Double(dataArray[dataIndex].duration)-player.currentTime().seconds)/60))
        let remainSecondText = numberFormatter.string(from: NSNumber(value: Int(Double(dataArray[dataIndex].duration)-player.currentTime().seconds)%60))
        remainLabel.text = remainMinuteText! + ":" + remainSecondText!
        
        if Int(player.currentTime().seconds) == dataArray[dataIndex].duration{
            if dataIndex > 0 && dataIndex < 4{
                dataIndex += 1
                loadMusicInformation(Index: dataIndex)
                executePlayOrPause(mode: .play, Index: dataIndex)
            }else if dataIndex == 0{
                dataIndex = 4
                loadMusicInformation(Index: dataIndex)
                executePlayOrPause(mode: .play, Index: dataIndex)
            }else if dataIndex == 4{
                dataIndex = 0
                loadMusicInformation(Index: dataIndex)
                executePlayOrPause(mode: .play, Index: dataIndex)
            }
        }
    }
    
}
