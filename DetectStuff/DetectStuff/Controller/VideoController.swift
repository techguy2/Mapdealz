//
//  ViewController.swift
//  DetectStuff
//
//  Created by Soeb on 8/27/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit
import AVKit
import Vision

class VideoController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let identifierTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Intialize Capture Session
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        //Intailize the device to use with Capture Session
        let captureDevice = AVCaptureDevice.default(for: .video)
        // Create input with Capture device
        guard let input = try? AVCaptureDeviceInput(device: captureDevice!) else {return}
        
        // Add input to Capture Device
        captureSession.addInput(input)
        
        //Start Capture Session
        captureSession.startRunning()
        
        // Setup Preiview layer to attach to view
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        // Attach to the viewcontroller view layer
        view.layer.addSublayer(previewLayer)
        view.addSubview(identifierTextView)
        // x, y, width and height
        identifierTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        identifierTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        identifierTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        identifierTextView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        previewLayer.frame = CGRect(x: 0, y: 50, width: view.bounds.width, height: view.bounds.height - 100)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label:"video"))
        captureSession.addOutput(dataOutput)

    }



    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer:CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {return}
        
        // Create Request
        let request = VNCoreMLRequest(model: model, completionHandler: { (finishReq, error) in
            
            guard let results = finishReq.results as? [VNClassificationObservation] else {return}
            guard let firstObservation = results.first else { return}
            
            DispatchQueue.main.async {
                if firstObservation.confidence > 0.1 {
                    self.identifierTextView.text = firstObservation.identifier
                } else {
                    self.identifierTextView.text = "Still Searching"
                }
            }
        })
        
        
        // Create Request Handler
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options:[:])
        
        try? imageRequestHandler.perform([request])
        

    }
       
    }


