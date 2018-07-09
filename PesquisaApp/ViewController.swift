//
//  ViewController.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 6/27/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//

import UIKit
import SwiftMessages

let finishedPoolKey = "key"

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        
        // Use data from the view controller which initiated the unwind segue
    }

    @IBAction func openPDF(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: finishedPoolKey) {
            let vc = PDFViewController()
            vc.navigationItem.title = "Livro"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureDropShadow()
            let backgroundColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            let foregroundColor = UIColor.darkText
            view.configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: #imageLiteral(resourceName: "alert-circle-256").imageWithColor(color: UIColor(red: 50/255, green: 143/255, blue: 212/255, alpha: 1)), iconText: nil)
            view.configureContent(title: "Erro", body: "Você ainda não possui acesso a esta área. Faça a pesquisa!")
            view.button?.isHidden = true
            SwiftMessages.show(view: view)
        }
    }
    
    @IBAction func openBlog(_ sender: Any) {
        let url = URL(string: "https://hugomontenegro.com.br/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @IBAction func openLinkedin(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/in/hugo-montenegro/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @IBAction func openInstagram(_ sender: Any) {
        let url = URL(string: "https://www.instagram.com/hugo_mmontenegro/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @IBAction func openTwitter(_ sender: Any) {
        let url = URL(string: "https://twitter.com/hugo_marcelo/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @IBAction func openFacebook(_ sender: Any) {
        let url = URL(string: "https://www.facebook.com/hugo.montenegro01")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
