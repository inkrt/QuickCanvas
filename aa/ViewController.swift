//
//  ViewController.swift
//  aa
//
//  Created by 舛水葵 on 2023/10/29.
//

import UIKit

import PencilKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    
    var colorPicker = UIColorPickerViewController()
    
    var penWidth: CGFloat = 15
    
    var penColor: UIColor = .black
    
    var penType: PKInkingTool.InkType = .pen
    
    var timer: Timer!
    
    var countdouwn: Int = 0
    
    var isPractice: Bool!
    
    var resultodai: String = ""
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var shotButton: UIButton!
    
    @IBOutlet var shareButton: UIButton!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var odailabel: UILabel!
    
    @IBOutlet var penButton: UIButton!
    
    @IBOutlet var toolSegment: UISegmentedControl!
    
    @IBOutlet var canvas: PKCanvasView!
    
    @IBOutlet var odaiButton: UIButton!
    
    @IBOutlet var odaiForImage: UILabel!
    
    @IBOutlet var timeForimage: UILabel!
    
    
    
    
    
    let odaiArray: [String] =
    ["うさぎ", "ねこ", "いぬ", "キリン", "モルモット", "ひつじ", "ぞう", "さる", "とり", "へび", "かに", "くま", "らいおん", "さめ", "かめ", "りす", "きつね", "らっこ", "くまのこ", "ひよこ", "いるか", "くじら", "かも", "こあら", "ねずみ", "らくだ", "かんがるー", "おおかみ", "とんぼ", "ことり", "さるねこ", "さるこ", "うそうさ", "とらぞう", "さめとり", "かにねこ", "ひつじねずみ", "こあらひつじ", "くじらひよこ", "さるとり", "ぞうかに", "かにぞう", "ねこいぬ", "いぬうさぎ", "とらきつね", "らいおんさめ", "りすくま", "さるくじら", "ぞうひつじ","女の子","男の子","セーラー服"]
    
    var index: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        odaiForImage.layer.cornerRadius = 20
        odaiForImage.layer.cornerCurve = .continuous
        odaiForImage.layer.masksToBounds = true
        timeForimage.layer.cornerRadius = 20
        timeForimage.layer.cornerCurve = .continuous
        timeForimage.layer.masksToBounds = true
        
        label.font = .monospacedDigitSystemFont(ofSize: 55, weight: .bold)
        
        colorPicker.selectedColor = UIColor.black
        colorPicker.delegate = self
        
        canvas.tool = PKInkingTool(.pen, color: penColor, width: penWidth)
        
        penButton.menu = UIMenu(title: "",options: .displayInline,children: [
            UIAction(title:"ペン"){ _ in
                self.penType = .pen
                
                self.updateTool()
                
            },
            UIAction(title:"えんぴつ"){ _ in
                self.penType = .pencil
                self.updateTool()
                
            },
        ])
        penButton.showsMenuAsPrimaryAction = true
        
        if isPractice == true{
            label.isHidden = true
            odailabel.isHidden = true
            odaiButton.isHidden = true
        }
    }
    
    
    
    @IBAction func shot(){
        UIImageWriteToSavedPhotosAlbum(exportImage(), nil, nil, nil)
        let alert: UIAlertController = UIAlertController(title: "保存",message: "保存しました",preferredStyle:  .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { action in
            print("okボタンが押されました")
        }))
        present(alert,animated: true,completion: nil)
        
        
        
    }
    
    @IBAction func reset(){
        let alert: UIAlertController = UIAlertController(title: "削除",message: "削除しますか",preferredStyle:  .alert)
        
        alert.addAction(UIAlertAction(title: "削除", style: .default,handler: { action in
            self.canvas.drawing = PKDrawing()
            
        })
        )
        alert.addAction(
            UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        )
        
        present(alert,animated: true,completion: nil)
        
        
        
    }
    
    @IBAction func peneraser(sender: UISegmentedControl){
        updateTool()
    }
    
    @IBAction func showColorPicker(){
        self.present(colorPicker, animated: true, completion: nil)
        colorPicker.preferredContentSize = CGSize(width: 200, height: 200)
        
    }
    
    func updateTool(){
        if toolSegment.selectedSegmentIndex == 0{
            canvas.tool = PKInkingTool(penType, color: penColor, width: penWidth)
        }else{
            canvas.tool = PKEraserTool(.bitmap, width: penWidth)
        }
        
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        penColor = color
        updateTool()
        
    }
    @IBAction func undo(){
        if let undoManager = canvas.undoManager{
            undoManager.undo()
        }
    }
    @IBAction func redo(){
        if let undoManager = canvas.undoManager{
            undoManager.redo()
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider){
        penWidth = CGFloat(sender.value)
        updateTool()
    }
    
    //    @IBOutlet var shareButton: UIButton!
    
    @IBAction func share(_ sender: UIButton){
        let shareImage = exportImage()
        let activityItem: [Any] = [shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        present(activityViewController, animated: true, completion: nil)
    }
    
    //   func dismiss(
    //    animated flag: Bool,
    //    campletion: (() -> Void)? = nil)
    
    //   @IBAction func time(){
    //        countdouwn = 10
    //
    //        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerCalled), userInfo: nil, repeats: true)
    //
    //        timer.fire()
    //    }
    
    @IBAction func change(){
        odaiButton.setImage(UIImage(systemName: "shuffle"), for: .normal)
        index = Int.random(in: 0...odaiArray.count-1)
        odailabel.text = odaiArray[index]
        countdouwn = Int.random(in: 10...30)
        odaiForImage.text = " " + odaiArray[index]
        timeForimage.text = " " + countdouwn.timerFormat + "秒"
        resultodai = "\(countdouwn.timerFormat)秒で描いた\(odaiArray[index])"
        if timer != nil{
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerCalled), userInfo: nil, repeats: true)
        
        timer.fire()
        
        self.canvas.drawing = PKDrawing()
        
        canvas.isUserInteractionEnabled = true
        
        backButton.isHidden = true
        shotButton.isHidden = true
        shareButton.isHidden = true
        odaiButton.isHidden = true
        
        
        
    }
    
    
    @objc func onTimerCalled(){
        
        label.text = countdouwn.timerFormat
        
        countdouwn -= 1
        
        if countdouwn < 0 {
            
            canvas.isUserInteractionEnabled = false
            
//            let stopAlert = UIAlertController(title: "終了", message: nil, preferredStyle: .alert)
//            let okACtion = UIAlertAction(title: "OK", style: .default)
//            
//            stopAlert.addAction(okACtion)
//            
//            present(stopAlert, animated: true)
            
            performSegue(withIdentifier: "toResult", sender: false)
            
            timer.invalidate()
        
            backButton.isHidden = false
            shotButton.isHidden = false
            shareButton.isHidden = false
            odaiButton.isHidden = false
        }
        
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    func exportImage() -> UIImage {
        if isPractice == false {
            odaiForImage.isHidden = false
            timeForimage.isHidden = false
        }
        let image = canvas.asImage()
        odaiForImage.isHidden = true
        timeForimage.isHidden = true
        return image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ResultViewController
        vc.resultImage = canvas.asImage()
        vc.resultodai = resultodai
    }
}


extension UIView{
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


extension Int {
    var timerFormat: String {
//        let remainingMinutes: Int = self / 60
//        let remainingSecound: Int = self % 60
//        
//        return String(format: "%02d:%02d", remainingMinutes, remainingSecound)
        String(format: "%02d", self)
    }
}
