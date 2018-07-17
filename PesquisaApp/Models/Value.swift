/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct User : Codable {
    var name : String = ""
    var email : String = ""
    var phone : String = ""
    var browser : String = ""
    
    var dict: [String: Any] {
        return ["name": name,
                "email": email,
                "phone": phone,
                "browser": browser] as [String:Any]
    }
}

struct JSON {
    var user: [String:Any] = [:]
    var answers: [[String: Any]] = []
    
    var dict: [String: Any] {
        return ["user": self.user,
                "answers": self.answers] as [String:Any]
    }
}

struct AnswerModel {
    var answer: [String: Any] = [:]
    var questionId: String = ""
    var userId: String?
    
    var dict: [String: Any] {
        return ["answer": answer,
                "questionId": questionId] as [String:Any]
    }
}

struct UserModelForAnswer {
	var name : String = ""
	var email : String = ""
	var phone : String = ""

    var dict: [String: Any] {
        return ["name": name,
                "email": email,
                "phone": phone] as [String:Any]
    }
}

struct UserValue {
    var value : [String: Any] = UserModelForAnswer(name: "", email: "", phone: "").dict
    
    var dict: [String: Any] {
        return ["value": value] as [String:Any]
    }
}

struct Value {
    var value : Int = -1
    var valueLiteral : String = ""
    var comment : String = ""
    
    var dict: [String: Any] {
        return ["value": value,
                "valueLiteral": valueLiteral,
                "comment": comment] as [String:Any]
    }
}

struct ValueCheckBox {
    var facebook : Bool = false
    var linkedin : Bool = false
    var instagram : Bool = false
    var twitter : Bool = false
    var outhers : Bool = false

    var dict: [String: Any] {
        return ["facebook": facebook,
                "linkedin": linkedin,
                "instagram": instagram,
                "twitter": twitter,
                "outhers": outhers] as [String:Any]
    }
}
