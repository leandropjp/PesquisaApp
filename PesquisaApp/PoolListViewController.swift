//
//  PoolListViewController.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 7/15/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//

import Foundation
import UIKit

class PoolListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: UITableViewStyle.plain)
        return tv
    }()
    var realizedPools = 0
    var newPools = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: "cellId")
        
        
        if UserDefaults.standard.bool(forKey: finishedPoolKey) {
            realizedPools += 1
        } else {
            newPools += 1
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Pesquisas"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Novas Pesquisas"
        } else {
            return "Pesquisas Realizadas"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if newPools == 0 {
                return 1
            }
            return newPools
        } else {
            if realizedPools == 0 {
                return 1
            }
            return realizedPools
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            if newPools == 0 {
                cell.textLabel?.text = "Não há pesquisas novas no momento."
                cell.textLabel?.textColor = UIColor.lightGray.withAlphaComponent(0.8)
            } else {
                cell.textLabel?.text = "Pesquisa sobre a neurociência."
            }
        } else {
            if realizedPools == 0 {
                cell.textLabel?.text = "Você ainda não realizou nenhuma pesquisas."
                cell.textLabel?.textColor = UIColor.lightGray.withAlphaComponent(0.8)
            } else {
                cell.textLabel?.text = "Pesquisa sobre a neurociência."
            }
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if newPools != 0 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewControllerID") as! QuestionViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if realizedPools != 0 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewControllerID") as! QuestionViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
}

class ListCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
