//
//  HomeViewController.swift
//  Scribble
//
//  Created by Nakul Bajaj on 2/4/17.
//  Copyright © 2017 nakulbajaj. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var createSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSessionButton.layer.cornerRadius = 40
        createSessionButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
