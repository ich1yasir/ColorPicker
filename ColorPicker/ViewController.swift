//
//  ViewController.swift
//  ColorPicker
//
//  Created by user209951 on 1/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var NumOfPixel: UITextField!
    @IBOutlet weak var imageRevieww: UIImageView!
    @IBOutlet weak var poinSelectedX: UITextField!
    @IBOutlet weak var poinSelectedY: UITextField!
    @IBOutlet weak var ImgH: UILabel!
    @IBOutlet weak var ImgW: UILabel!
    @IBOutlet weak var pickArea: UIView!
    @IBOutlet weak var RgBresult: UILabel!
    @IBOutlet weak var pickImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTest:UIImage? = UIImage(named:"testImage")
        imageRevieww.image = imageTest// Do any additional setup after loading the view.
        let w = Int(imageTest!.size.width)
        let h = Int(imageTest!.size.height)
        ImgH.text = h.description
        ImgW.text = w.description
        poinSelectedX.text = Int(exactly: (w/2))?.description
        poinSelectedY.text = Int(exactly: (h/2))?.description
        reloadPicker()
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
        //let color = iamgeCroped.averageColor
        let color = iamgeCroped.maximumColor
        let pxlData = iamgeCroped.pixelData()
        pickArea.backgroundColor = color ?? .clear
        RgBresult.text = hexStringFromColor(color: color ?? .darkGray)
        
    }
    
    

}

