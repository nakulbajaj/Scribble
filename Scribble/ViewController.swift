//
//  ViewController.swift
//  Scribble
//
//  Created by Nakul Bajaj on 2/4/17.
//  Copyright © 2017 nakulbajaj. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate{

    @IBOutlet var slider: UISlider!
    var bounds = UIScreen.main.bounds
    @IBOutlet var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    var thickness:Int = 5
    var isEraserSelected = false;
    var currentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    
    @IBOutlet var greenColor: UIButton!
    @IBOutlet var redColor: UIButton!
    @IBOutlet var blueColor: UIButton!
    @IBOutlet var blackColor: UIButton!
    @IBOutlet var paintPressed: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var eraserButton: UIButton!
    @IBAction func eraserPressed(_ sender: UIButton) {
        if(isEraserSelected == false){
        currentColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
            eraserButton.setImage(UIImage(named: "pencil"), for: UIControlState.normal)
            hideEverything()
            isEraserSelected = true
        }
        else {
            currentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
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
    self.imageView.image = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        revealPalette()
        buttonCrazy()
        startRecording()
        
      
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
                    cameraPreview.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                    self.view.addSubview(cameraPreview)
                    cameraPreview.layer.borderWidth = 10
                    cameraPreview.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 0.25).cgColor
            }
            
            }
        }
    }

    func stopRecording() {
        let recorder = RPScreenRecorder.shared()
        
        recorder.stopRecording { [unowned self] (preview, error) in
            
            if let unwrappedPreview = preview {
                unwrappedPreview.previewControllerDelegate = self
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint){
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x:fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(thickness))
        context?.setStrokeColor(currentColor.cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func isPaintPressed() {
        hidePalette()
    }
    @IBAction func isBlackPressed() {
        currentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        revealPalette()
    }
    
    @IBAction func isGreenPressed() {
        currentColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1.0)
        revealPalette()
    }
    
    @IBAction func isRedPressed() {
        currentColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        revealPalette()
    }
    
    @IBAction func isBluePressed() {
        currentColor = UIColor(red: 28/255, green: 164/255, blue: 252/255, alpha: 1.0)
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
        thickness = Int(sender.value)
    }
    

}

