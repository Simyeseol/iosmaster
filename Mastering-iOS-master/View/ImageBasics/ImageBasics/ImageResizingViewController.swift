//
//  Copyright (c) 2018 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import CoreGraphics

// 방법 2개
class ImageResizingViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
    let targetImage = UIImage(named:"photo")
    let size = CGSize(width:(targetImage?.size.width)! / 5, height: (targetImage?.size.height)! / 5)
      
    //imageView.image = resizingWithImageContext(image: //targetImage!, to: size)
    
    imageView.image = resizingWithBitmapContext(image: targetImage!, to: size)
   }
}




extension ImageResizingViewController {
    /* resizing할 이미지랑 resizing할 크기를 parameter로 받음. */
   func resizingWithImageContext(image: UIImage, to size: CGSize) -> UIImage? {
    //무언가를 그릴 수 있는 임시 그림판 생성
    /* UIKit 프레임워크에 구현되어 있는 함수, 무언가를 그릴 수 있는 임시그림판 생성, 첫번째 파라미터 : 크기. 두번째 파라미터: 투명한 부분이 없다면 true전달, 세번째 파라미터: 0.0 은 device scale  */
    UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
    
    //위의 함수를 호출한 후에는 그리기 메서드를 통해서 이미지나 텍스트를 자유롭게 그릴 수 있음
    let frame =  CGRect(origin: CGPoint.zero, size: size)
    
    image.draw(in: frame)
    
    //현재 사용중인 ImageContext에서 이미지를 가져오는 함수.
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    
    //이렇게 끝내는 함수 꼭 잇어야
    UIGraphicsEndImageContext()

    return resultImage

    }
}



extension ImageResizingViewController {
   func resizingWithBitmapContext(image: UIImage, to size: CGSize) -> UIImage? {
    
    guard let cgImage = image.cgImage else {
        return nil
    }
    
    let bpc = cgImage.bitsPerComponent
    let bpr = cgImage.bytesPerRow
    let colorSpace = cgImage.colorSpace!
    let bitmapInfo = cgImage.bitmapInfo
    
    
    
    
   guard let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: bpc, bytesPerRow: bpr, space: colorSpace, bitmapInfo:  bitmapInfo.rawValue) else {
        return nil
    }
    context.interpolationQuality = .high
    
    let frame = CGRect(origin: CGPoint.zero, size: size)
    
    context.draw(cgImage, in : frame)
    
    guard let resultImage = context.makeImage()
    else {
        return nil
        
    }
    
    return UIImage(cgImage: resultImage)
    
   }
    
}













