//
//  ViewController.swift
//  Quiz Game App
//
//  Created by Felipe Ignacio Zapata Riffo on 16-08-21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startGame (){
        
        let vc = storyboard?.instantiateViewController(identifier: "game") as? GameViewController
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true)
         
    }
}

