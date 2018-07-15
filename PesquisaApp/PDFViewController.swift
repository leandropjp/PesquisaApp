//
//  PDFViewController.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 7/7/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//

import Foundation
import UIKit

class PDFViewController: UIViewController, UIWebViewDelegate {
    
    let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.hidesWhenStopped = true
        activity.color = .gray
        activity.startAnimating()
        navigationItem.title = "Livro"
        let webView = UIWebView()
        let pdf = Bundle.main.url(forResource: "IMPULSIVAMENTE", withExtension: "pdf", subdirectory: nil, localization: nil)
        let requestObj = URLRequest(url: pdf!)
        webView.loadRequest(requestObj)
        webView.delegate = self
        view.addSubview(webView)
        view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activity.heightAnchor.constraint(equalToConstant: 60).isActive = true
        activity.widthAnchor.constraint(equalToConstant: 60).isActive = true
        webView.anchorToEntireView(of: view)
        
        let btn = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(downloadPDF))
        self.navigationItem.rightBarButtonItem = btn
        addBackButton()
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(#imageLiteral(resourceName: "icon-back-gray").imageWithColor(color: .black)?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.setTitle(nil, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
    }
    
    @objc func downloadPDF() {
        if let pdf = Bundle.main.url(forResource: "IMPULSIVAMENTE", withExtension: "pdf", subdirectory: nil, localization: nil), let data = try? Data(contentsOf: pdf)  {
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
