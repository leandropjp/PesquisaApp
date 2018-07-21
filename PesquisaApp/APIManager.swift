//
//  APIManager.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 7/11/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: NSObject {
    static let shared = APIManager()
    func sendAnswers(data: [Answer], completion: @escaping (Int)-> Void ) {
        let url = URL(string: "https://hugomontenegro.lienotecnologia.com.br/api/Answers/saveAll")
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        var user = User(name: "", email: "", phone: "", browser: deviceID ?? "noId")
        let userAnswer = data.first!

        for (index,value) in userAnswer.text.enumerated() {
            if index == 0 {
                user.name = value
            }
            if index == 1 {
                user.email = value
            }
            
            if index == 2 {
                user.phone = value
            }
        }
        
        
        var answers: [[String: Any]] = []
        let userModel = UserModelForAnswer(name: user.name, email: user.email, phone: user.phone)
        let userValue = UserValue(value: userModel.dict)
        var dict = userValue.dict
        dict["valueLiteral"] = ""
        let firstAns = AnswerModel(answer: dict, questionId: arrayID[0], userId: nil)
        answers.append(firstAns.dict)
        
        for (index,item) in data.enumerated() {
            if index == 0 {
                continue
            }
            
            if index == 17 {
                var value = ValueCheckBox(facebook: false, linkedin: false, instagram: false, twitter: false, outhers: false)
                for i in item.indexes {
                    switch (i) {
                    case 1:
                        value.facebook = true
                    case 2:
                        value.linkedin = true
                    case 3:
                        value.instagram = true
                    case 4:
                        value.twitter = true
                    default:
                        value.outhers = true
                    }
                }
                let valueDict = ["value": value.dict]
                let ans = AnswerModel(answer: valueDict, questionId: arrayID[index], userId: nil)
                answers.append(ans.dict)
            } else {
                var value = Value(value: -1, valueLiteral: "", comment: "")
                for i in item.indexes {
                    value.value = i
                }
                
                for i in item.selected {
                    value.valueLiteral = i
                }
                
                for i in item.text {
                    value.comment = i
                }
                
                let ans = AnswerModel(answer: value.dict, questionId: arrayID[index], userId: nil)
                
                if index == 1 {
                    let dict: [String: Any] = ["answer": ["value": "\(value.value)",
                        "valueLiteral": value.valueLiteral,
                        "comment": value.comment], "questionId": arrayID[index]]
                    answers.append(dict)
                } else {
                    if index == 12 {
                        var tmp = ans.dict
                        if var empresa = ans.dict["answer"] as? [String: Any] {
                            empresa["comment"] = ""
                            empresa["value"] = item.text.first ?? ""
                            tmp["answer"] = empresa
                            answers.append(tmp)
                        }
                    } else {
                        answers.append(ans.dict)
                    }
                    
                }
            }
        }
        let json = JSON(user: user.dict, answers: answers)
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: json.dict, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let jsonData = try encoder.encode(AppConfig.shared.answers)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonString)
        } catch {
            print(error)
        }
        
        request(url!, method: .post, parameters: json.dict ?? [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.debugDescription)
            
            if let json = response.result.value as? [String: Any], let user = json["user"] as? [String: Any], let position = user["number"] as? Int {
                completion(position)
            }
        }
        
    }
}
