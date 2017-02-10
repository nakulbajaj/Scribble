//
//  ViewController.swift
//  Scribble
//
//  Created by Nakul Bajaj on 2/4/17.
//  Copyright © 2017 nakulbajaj. All rights reserved.
//

import UIKit
import ReplayKit


class SharingManager {
    var sharedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    var sharedThickness: CGFloat = 5
    static let sharedInstance = SharingManager()
}

class ViewController: UIViewController, RPPreviewViewControllerDelegate{

    @IBOutlet var slider: UISlider!
    var bounds = UIScreen.main.bounds
    static let sharedInstance = ViewController()
    
    var isEraserSelected = false

    
    @IBOutlet var greenColor: UIButton!
    @IBOutlet var redColor: UIButton!
    @IBOutlet var blueColor: UIButton!
    @IBOutlet var blackColor: UIButton!
    @IBOutlet var paintPressed: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var eraserButton: UIButton!
    
    
    @IBAction func eraserPressed(_ sender: UIButton) {
        if(isEraserSelected == false){
        SharingManager.sharedInstance.sharedColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
            eraserButton.setImage(UIImage(named: "pencil"), for: UIControlState.normal)
            hideEverything()
            isEraserSelected = true
        }
        else {
            SharingManager.sharedInstance.sharedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            eraserButton.setImage(UIImage(named: "eraser"), for: UIControlState.normal)
            revealPalette()
            isEraserSelected = false
        }
    }

    func hideEverything(){
        paintPressed.isHidden=true;
        blackColor.isHidden=true;
        greenColor.isHidden=true;
        blueColor.isHidden=true;
        redColor.isHidden=true;
    }
    
    @IBAction func clearEverything() {
 //Do something
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        revealPalette()
        buttonCrazy()
        startRecording()
        SharingManager.sharedInstance.sharedColor = UIColor.black
        SharingManager.sharedInstance.sharedThickness = 5
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    func buttonCrazy(){
        stopButton.layer.cornerRadius = 40
        stopButton.clipsToBounds = true
        blueColor.layer.cornerRadius = 20
        blueColor.clipsToBounds = true
        redColor.layer.cornerRadius = 20
        redColor.clipsToBounds = true
        greenColor.layer.cornerRadius = 20
        greenColor.clipsToBounds = true
        blackColor.layer.cornerRadius = 20
        blackColor.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        revealPalette()
        buttonCrazy()
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    func startRecording() {
        let recorder = RPScreenRecorder.shared()
        recorder.isCameraEnabled = true
        recorder.isMicrophoneEnabled = true
        
        recorder.startRecording { [unowned self] (error) in
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
            } else {
                if let cameraPreview = RPScreenRecorder.shared().cameraPreviewView {
                    cameraPreview.frame = CGRect(x: 5, y: 5, width: 100, height: 117)
                    self.view.addSubview(cameraPreview)
                    cameraPreview.layer.borderWidth = 3
                    cameraPreview.layer.borderColor = UIColor(red:251/255, green:128/255, blue:47/255.0, alpha: 0.75).cgColor
            }
            
            }
        }
    }

    func stopRecording() {
        let recorder = RPScreenRecorder.shared()
        
        recorder.stopRecording { [unowned self] (preview, error) in
            
            if let unwrappedPreview = preview {
                unwrappedPreview.previewControllerDelegate = self

                //iPAD
            unwrappedPreview.popoverPresentationController?.sourceView = self.view
        unwrappedPreview.popoverPresentationController?.passthroughViews = [self.view]
            //self.view.isUserInteractionEnabled = false
                self.present(unwrappedPreview, animated: true)

            }
        }
    }
    

    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "homeVC")
        self.present(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func isPaintPressed() {
        hidePalette()
    }
    @IBAction func isBlackPressed() {
        SharingManager.sharedInstance.sharedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        revealPalette()
    }
    
    @IBAction func isGreenPressed() {
        SharingManager.sharedInstance.sharedColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1.0)
        revealPalette()
    }
    
    @IBAction func isRedPressed() {
        SharingManager.sharedInstance.sharedColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        revealPalette()
    }
    
    @IBAction func isBluePressed() {
        SharingManager.sharedInstance.sharedColor = UIColor(red: 28/255, green: 164/255, blue: 252/255, alpha: 1.0)
        revealPalette()
        
    }
    
    
    func revealPalette(){
        paintPressed.isHidden=false;
        blackColor.isHidden=true;
        greenColor.isHidden=true;
        blueColor.isHidden=true;
        redColor.isHidden=true;

    }
    func hidePalette(){
        paintPressed.isHidden=true;
        blackColor.isHidden=false;
        greenColor.isHidden=false;
        blueColor.isHidden=false;
        redColor.isHidden=false;
    }
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopRecording()
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        SharingManager.sharedInstance.sharedThickness = CGFloat(sender.value)
    }
    

}

