//
//  ViewController.swift
//  i wanna live photo
//
//  Created by 위대연 on 2022/11/01.
//

import UIKit
import Photos

struct Debug {
    let fileName: String
    func log(_ items: Any ...) {
        print("\(fileName) : ", items)
    }
}

class ViewController: UIViewController {
    let debug: Debug = .init(fileName: .init(describing: ViewController.self))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /** fileName.gif -> name: fileName, return GIF()*/
    func loadGIFFile(name: String) -> GIF? {
        do {
            guard let imageURL: URL = Bundle.main.url(forResource: name, withExtension: "gif") else {
                throw CustomError.notFound
            }
            
            let imageData: Data = try Data(contentsOf: imageURL)
            guard let gif: GIF = .init(data: imageData) else {
                throw CustomError.invalidData
            }
            
            return gif
        } catch {
            self.debug.log(error)
            return nil
        }
    }
}

enum CustomError: String, Error {
    case notFound = "파일을 찾을 수 없어요"
    case invalidData = "이 데이터는 GIF클래스로 변환할 수 없습니다."
}
