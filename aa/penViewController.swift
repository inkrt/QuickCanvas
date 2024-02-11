//
//  penViewController.swift
//  aa
//
//  Created by 舛水葵 on 2023/12/10.
//

import UIKit

import PencilKit

class penViewController: UIViewController{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func pen(){
        canvas.tool = PKInkingTool(.pencil, color: penColor, width: penWidth)
        currentTool = 1
    }
    
    
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


