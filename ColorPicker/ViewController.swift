//
//  ViewController.swift
//  ColorPicker
//
//  Created by ichwan on 1/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var NumOfPixel: UITextField!
    @IBOutlet weak var imageRevieww: UIImageView!
    @IBOutlet weak var poinSelectedX: UITextField!
    @IBOutlet weak var poinSelectedY: UITextField!
    @IBOutlet weak var pickArea: UIView!
    @IBOutlet weak var RgBresult: UILabel!
    @IBOutlet weak var pickImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        let imageTest:UIImage? = UIImage(named:"testImage")
        imageRevieww.image = imageTest// Do any additional setup after loading the view.
        reloadPicker()
    }
    @objc func handleTap() {
        NumOfPixel.resignFirstResponder()
        poinSelectedX.resignFirstResponder()
        poinSelectedY.resignFirstResponder() // dismiss keyoard
    }
    
    
    @IBAction func onGetColorClick(_ sender: Any) {
        reloadPicker()
    }
    func cropImage1(image: UIImage, rect: CGRect) -> UIImage {
        let cgImage = image.cgImage! // better to write "guard" in realm app
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let formattedrgb = String(format: "r: %.2f g: %.2f b: %.2f", r, g, b)
        
        return  formattedrgb
     }
    
    func reloadPicker(){
        let imageTest = imageRevieww.image
        let x = Double(poinSelectedY.text!)
        let y = Double(poinSelectedX.text!)
        let px = Double(NumOfPixel.text!)
        let rect_ = CGRect(x: x!, y: y!, width: px!, height: px!)
        let iamgeCroped = cropImage1(image: imageTest!, rect: rect_)
        pickImage.image = iamgeCroped
        let color = iamgeCroped.averageColor
        //let color = iamgeCroped.mostFrequence
        //let color = iamgeCroped.maximumColor
        //let pxlData = iamgeCroped.pixelData()
        pickArea.backgroundColor = color ?? .clear
        RgBresult.text = hexStringFromColor(color: color ?? .darkGray)
        
    }
    
    

}

