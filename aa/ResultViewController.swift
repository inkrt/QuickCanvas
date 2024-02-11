//
//  ResultViewController.swift
//  aa
//
//  Created by 舛水葵 on 2024/02/11.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultImageView: UIImageView!
    
    @IBOutlet var odailabel: UILabel!
    
    @IBOutlet var shotButton: UIButton!
    
    @IBOutlet var shareButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    var resultImage: UIImage!
    
    var resultodai: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultImageView.image = resultImage
        
        odailabel.text = resultodai
        

        // Do any additional setup after loading the view.
    }

    @IBAction func shot(){
        UIImageWriteToSavedPhotosAlbum(exportImage(), nil, nil, nil)
        let alert: UIAlertController = UIAlertController(title: "保存",message: "保存しました",preferredStyle:  .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { action in
            print("okボタンが押されました")
        }))
        present(alert,animated: true,completion: nil)
        
        
    }
    @IBAction func share(_ sender: UIButton){
        let shareImage = exportImage()
        let activityItem: [Any] = [shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }

    
    func exportImage() -> UIImage {
        shotButton.isHidden = true
        shareButton.isHidden = true
        backButton.isHidden = true
        let image = view.asImage()
        shotButton.isHidden = false
        shareButton.isHidden = false
        backButton.isHidden = false
        return image
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
