//
//  Json.swift
//  PesquisaApp
//
//  Created by Leandro Paiva Andrade on 6/28/18.
//  Copyright © 2018 Lieno Tecnologia. All rights reserved.
//

import Foundation
import UIKit

let radioFlag = "(Radio)"
let textFlag = "(Text)"
let textNumberFlag = "(TextNumber)"
let commentFlag = "(Comment)"
let checkFlag = "(CheckBox)"
let ifFlag = "(if)"
class AppConfig: NSObject {
    static let shared = AppConfig()

    var questions = [Question(dict: question1) ,Question(dict: question2), Question(dict: question3), Question(dict: question4), Question(dict: question5), Question(dict: question6),
                     Question(dict: question7), Question(dict: question8), Question(dict: question9), Question(dict: question10),Question(dict: question11),Question(dict: question12),
                     Question(dict: question13), Question(dict: question14),Question(dict: question15),Question(dict: question16),Question(dict: question17),Question(dict: question18),
                     Question(dict: question19),Question(dict: question20),Question(dict: question21),Question(dict: question22),Question(dict: question23),Question(dict: question24),
                     Question(dict: question25),Question(dict: question26),Question(dict: question27),Question(dict: question28),Question(dict: question29),
                     Question(dict: question30),Question(dict: question31),Question(dict: question32),Question(dict: question33),Question(dict: question34), Question(dict: question35)]
    var questionsCount = 0
    
    var answers = [Answer](repeating: Answer(), count: 35)
    
    var progressBarValue: CGFloat = 0
    
    var progressNotification = [1, 11, 18, 26, 35]

}

struct Question {
    var question: String = ""
    var answers: [String] = []
    
    init(dict: [String:Any]) {
        if let qt = dict["question"] as? String {
            self.question = qt
        }
        
        if let ans = dict["answers"] as? [String] {
            self.answers = ans
        }
    }
}

struct Answer: Codable {
    var text: [String] = []
    var selected: [String] = []
    var indexes: [Int] = []
}

let question1: [String: Any] = ["question": "Identificação(opcional):",
                 "answers": ["Nome*(Text)", "Email*(Text)", "Telefone*(Text)"]]

let question2: [String: Any] = ["question": "Qual a sua idade?",
                                "answers": ["Idade*(TextNumber)"]]

let question3: [String: Any] = ["question": "Sexo:",
                                "answers": ["Masculino*(Radio)", "Feminino*(Radio)"]]

let question4: [String: Any] = ["question": "Você é casado?",
                                "answers": ["Sim*(Radio)", "Não*(Radio)"]]

let question5: [String: Any] = ["question": "Você possui filhos?",
                                "answers": ["Sim*(Radio)", "Não*(Radio)"]]

let question6: [String: Any] = ["question": "Qual seu cargo ou função?",
                                "answers": ["Gestor*(Radio)", "Diretor*(Radio)", "Sócio*(Radio)"]]

let question7: [String: Any] = ["question": "Quantas vezes por semana você faz atividade física?",
                                "answers": ["Nenhuma vez na semana*(Radio)", "Pelo menos 1X*(Radio)", "2X na semana*(Radio)", "Mais de 3X na semana*(Radio)"]]

let question8: [String: Any] = ["question": "Qual seu objetivo pessoal?",
                                "answers": ["Aumentar o patrimônio*(Radio)", "Um novo cargo*(Radio)", "Comprar um imóvel*(Radio)","Outros*(Radio)(Comment)(if)"]]

let question9: [String: Any] = ["question": "Você está estudando/especializando-se atualmente?",
                                "answers": ["Sim*(Radio)", "Não*(Radio)"]]

let question10: [String: Any] = ["question": "Você leva trabalho para casa?",
                                "answers": ["Sim*(Radio)", "Não*(Radio)"]]

//Exibir Notificação "Continue assim"

let question11: [String: Any] = ["question": "Você separa a vida pessoal e profissional?",
                                "answers": ["Sempre*(Radio)","Quase sempre*(Radio)","Quase nunca*(Radio)", "Nunca*(Radio)"]]

let question12: [String: Any] = ["question": "Seu planejamento de carreira é:",
                                "answers": ["Menor que 2 anos*(Radio)", "Entre 2 e 5 anos*(Radio)","Maior que 5 anos*(Radio)"]]

let question13: [String: Any] = ["question": "Em qual empresa você trabalha (opcional)?",
                                "answers": ["Empresa*(Text)"]]

let question14: [String: Any] = ["question": "Qual o ramo de atividade da sua empresa?",
                                 "answers": ["Varejo*(Radio)","Serviço*(Radio)","Comércio*(Radio)","Indústria*(Radio)"]]

let question15: [String: Any] = ["question": "Como você classifica sua empresa?",
                                 "answers": ["ME (Micro Empresa)*(Radio)","EPP (Empresa de Pequeno Porte)*(Radio)","EMP (Empresa de Médio Porte)*(Radio)","EGP (Empresa de Grande Porte)*(Radio)"]]

let question16: [String: Any] = ["question": "Qual o tempo de atuação da sua empresa no mercado?",
                                 "answers": ["Menos que 5 anos*(Radio)", "Entre 5 e 10 anos*(Radio)","Mais que 10 anos*(Radio)"]]

let question17: [String: Any] = ["question": "Como você considera a abrangência de atuação da sua empresa?",
                                 "answers": ["Local*(Radio)","Regional*(Radio)","Nacional*(Radio)"]]

//Exibir Notificação "Você já alcançou metade do caminho"

let question18: [String: Any] = ["question": "Em quais redes sociais sua empresa possui atuação?",
                                 "answers": ["Facebook*(CheckBox)","LinkedIn*(CheckBox)","Instagram*(CheckBox)","Twitter*(CheckBox)","Outras*(CheckBox)(Comment)(if)"]]

let question19: [String: Any] = ["question": "Quantas pessoas você lidera diretamente?",
                                 "answers": ["Menos que 5 pessoas*(Radio)","Entre 5 e 10 pessoas*(Radio)","Mais que 10 pessoas*(Radio)"]]

let question20: [String: Any] = ["question": "Sua empresa possui atualmente um Planejamento estratégico definido?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]

let question21: [String: Any] = ["question": "O planejamento estratégico, uma vez definido, sofre alterações durante o ano?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]
    
let question22: [String: Any] = ["question": "Sua empresa utiliza a Matriz Swot?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]

let question23: [String: Any] = ["question": "Sua empresa utiliza indicadores de gestão?",
                                 "answers": ["Sim*(Radio)(Comment)(if)%Poderia citar alguns?%", "Não*(Radio)"]]
//if "sim" exibir (TextBox) "Poderia citar alguns?"

let question24: [String: Any] = ["question": "Mudanças de estratégia são comuns em sua empresa?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]
    
let question25: [String: Any] = ["question": "Você considera que as mudanças no ambiente externo impactam no planejamento da empresa em qual nível?",
                                 "answers": ["Pouco impacto*(Radio)","Médio impacto*(Radio)", "Alto impacto*(Radio)"]]

//Exibir Notificação "Você está prestes a ganhar o livro digital"

let question26: [String: Any] = ["question": "Você considera que mudanças na sua empresa são rápidas e eficazes conforme muda o mercado?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]

let question27: [String: Any] = ["question": "Você considera que sua empresa domina e entende o comportamento de compra de seu cliente?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]
    
let question28: [String: Any] = ["question": "Você acredita que os conceitos da neurociência podem ser aplicados na gestão empresarial?",
                                 "answers": ["Sim*(Radio)(Comment)(if)%Comentário%", "Não*(Radio)"]]
//if "sim" exibir (TextBox) "Comentário"

let question29: [String: Any] = ["question": "Você já ouviu falar em Neuromarketing?",
                                 "answers": [" Sim, conheço e aplico*(Radio)", "Sim, mas não sei do que se trata*(Radio)","Não ouvi falar*(Radio)"]]
    
let question30: [String: Any] = ["question": "Você já ouviu falar em Neuroeconomia?",
                                 "answers": ["Sim*(Radio)(Comment)(if)%Comentário%", "Não*(Radio)"]]
//if "sim" exibir (TextBox) "Comentário"

let question31: [String: Any] = ["question": "Você já ouviu falar no termo Neuroestratégia?",
                                 "answers": ["Sim*(Radio)(Comment)(if)%Comentário%", "Não*(Radio)"]]
//if "sim" exibir (TextBox) "Comentário"

let question32: [String: Any] = ["question": "Você já ouviu falar em ancoragem de preços?",
                                 "answers": ["Sim*(Radio)(Comment)(if)%Comentário%", "Não*(Radio)"]]
//if "sim" exibir (TextBox) "Comentário"
let question33: [String: Any] = ["question": "O que você acha mais relevante para o seu cliente?",
                                 "answers": ["Preço*(Radio)", "Experiência*(Radio)"]]

let question34: [String: Any] = ["question": "Você utiliza marketing sensorial na sua organização?",
                                 "answers": ["Sim*(Radio)(Comment)(if)%Comentário%", "Não*(Radio)", "Desconheço*(Radio)"]]
//if "sim" exibir (TextBox) "Comentário"
let question35: [String: Any] = ["question": "Você acha que a neurociência aplicada na sua organização pode contribuir para o sucesso da gestão?",
                                 "answers": ["Sim*(Radio)", "Não*(Radio)"]]

//Exibir Notificação "Fim da pesquisa"

//Obrigado! Você é o 8º a responder a pesquisa.
//Tenha acesso gratuito ao livro IMPULSIVA-MENTE em formato digital.
//
//DOWNLOAD

let arrayID = ["5b30410e2ac62c6af9f03c43",
               "5b30410e2ac62c6af9f03c44",
               "5b30410e2ac62c6af9f03c45",
               "5b30410e2ac62c6af9f03c46",
               "5b30410e2ac62c6af9f03c47",
               "5b30410e2ac62c6af9f03c48",
               "5b30410e2ac62c6af9f03c49",
               "5b30410e2ac62c6af9f03c4a",
               "5b30410e2ac62c6af9f03c4b",
               "5b30410e2ac62c6af9f03c4c",
               "5b30410e2ac62c6af9f03c4d",
               "5b30410e2ac62c6af9f03c4e",
               "5b30410e2ac62c6af9f03c4f",
               "5b30410e2ac62c6af9f03c50",
               "5b30410e2ac62c6af9f03c51",
               "5b30410e2ac62c6af9f03c52",
               "5b30410e2ac62c6af9f03c53",
               "5b30410e2ac62c6af9f03c54",
               "5b30410e2ac62c6af9f03c55",
               "5b30410e2ac62c6af9f03c56",
               "5b30410e2ac62c6af9f03c57",
               "5b30410e2ac62c6af9f03c58",
               "5b30410e2ac62c6af9f03c59",
               "5b30410e2ac62c6af9f03c5a",
               "5b30410e2ac62c6af9f03c5b",
               "5b30410e2ac62c6af9f03c5c",
               "5b30410e2ac62c6af9f03c5d",
               "5b30410e2ac62c6af9f03c5e",
               "5b30410e2ac62c6af9f03c5f",
               "5b30410e2ac62c6af9f03c60",
               "5b30410e2ac62c6af9f03c61",
               "5b30410e2ac62c6af9f03c62",
               "5b30410e2ac62c6af9f03c63",
               "5b30410e2ac62c6af9f03c64",
               "5b30410e2ac62c6af9f03c65"]
