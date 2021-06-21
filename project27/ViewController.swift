//
//  ViewController.swift
//  project27
//
//  Created by Ярослав on 5/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var currentDrowType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
        // Do any additional setup after loading the view.
    }

    @IBAction func redrowTapped(_ sender: UIButton) {
        currentDrowType += 1
        
        if currentDrowType > 6{
            currentDrowType = 0
        }
        
        switch currentDrowType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 5:
            drawLines()
        case 4:
            drawImagesAndText()
        default:
            break
        }
    }
    
    
//    func drawClock(){
//            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
//
//        let image = renderer.image{context in
//            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 10, dy: 10)
//            let hourHandLength = rectangle.width/2 * 0.2
//            let minutHandLength = rectangle.width/2 * 0.75
//            // gray circle
//            context.cgContext.addEllipse(in: rectangle)
//            context.cgContext.setFillColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor)
//            //context.cgContext.fillPath()
//
//            //stroke
//            context.cgContext.setLineWidth(15)
//            context.cgContext.setStrokeColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor)
//           // context.cgContext.drawPath(using: .fillStroke)
//
//            //clock hands
//           // context.cgContext.translateBy(x: rectangle.midX, y: rectangle.midY)
//            //context.cgContext.rotate(by: .pi/2)
//            context.cgContext.addLines(between: [CGPoint(x: rectangle.midX, y: rectangle.midY),CGPoint(x: rectangle.midX + (minutHandLength * minutHandLength)*cos(.pi/2), y: rectangle.midY + (minutHandLength * minutHandLength)*sin(.pi/2))])
//           // context.cgContext.addLine(to: CGPoint(x: rectangle.midX + (minutHandLength * minutHandLength)*cos(.pi/2), y: rectangle.midY + (minutHandLength * minutHandLength)*sin(.pi/2)))
//            context.cgContext.setStrokeColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor)
//            context.cgContext.drawPath(using: .fillStroke)
//
//        }
//        imageView.image = image
//    }
    
    func drawImagesAndText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image{ context in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key:Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best text style of the best, of the best"
            let attrebutedString = NSAttributedString(string: string, attributes: attrs)
            
            attrebutedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        imageView.image = image
    }
    
    func drawLines(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512 ))
        let image = renderer.image{ context in
            context.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0..<256{
                context.cgContext.rotate(by: .pi/2)
                if first{
                    context.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                }else{
                    context.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.strokePath()
        }
        imageView.image = image
    }
    
    func drawRotatedSquares(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image{ context in
            context.cgContext.translateBy(x: 256, y: 256)
            let rotation = 32
            let amount = Double.pi/Double(rotation)
            
            for _ in 0..<rotation{
                context.cgContext.rotate(by: CGFloat(amount))
                context.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.strokePath()
        }
        imageView.image = image
    }
    
    func drawCheckerboard(){
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { context in
            let rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 512, height: 512))
            context.cgContext.setFillColor(UIColor.black.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(6)
            context.cgContext.addRect(rectangle)
            context.cgContext.drawPath(using: .stroke)
            for row in 0..<8{
                for col in 0..<8{
                    if (row + col) % 2 == 0{
                        context.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    func drawCircle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image{ context in
            let rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 512, height: 512)).insetBy(dx: 5, dy: 5)
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addEllipse(in: rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    func drawRectangle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image{ context in
            let rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 512, height: 512)).insetBy(dx: 5, dy: 5)
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addRect(rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    
}

