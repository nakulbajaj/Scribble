//
//  TransitionViewController.swift
//  Scribble
//
//  Created by Nakul Bajaj on 2/4/17.
//  Copyright © 2017 nakulbajaj. All rights reserved.
//

import UIKit

var countdownInt = 3
var timer = Timer()

class TransitionViewController: UIViewController {

    @IBOutlet var countdownLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        var countdownInt = 3
        
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countdownInt = 3
        super.viewDidAppear(true)
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    func update() {
        if countdownInt != 0 {
            countdownInt -= 1
            var numberFromString = String(countdownInt)
            countdownLabel.text = numberFromString
        }
        else {
            countdownInt = 3
            timer.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "drawVC")
            self.present(controller, animated: true, completion: nil)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
