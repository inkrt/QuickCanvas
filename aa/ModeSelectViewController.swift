//
//  ModeSelectViewController.swift
//  aa
//
//  Created by 舛水葵 on 2024/01/14.
//

import UIKit

class ModeSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func practiceMode(){
        performSegue(withIdentifier: "toDraw", sender: true)
        
    }
        @IBAction func playMode(){
        performSegue(withIdentifier: "toDraw", sender: false)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.isPractice = sender as? Bool
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
