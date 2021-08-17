//
//  GameViewController.swift
//  Quiz Game App
//
//  Created by Felipe Ignacio Zapata Riffo on 16-08-21.
//

import UIKit
struct Question {
    let text: String
    let answers:[Answers]
}

struct Answers {
    let text:String
    let correct:Bool
}


class GameViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet var label:UILabel!
    @IBOutlet var tableView:UITableView!
    var gameModels = [Question]()
    
    var currentQuestion:Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpQuestion()
        configureUI(question: gameModels.first!)
       
    }
    private func configureUI(question: Question){
        label.text = question.text
        currentQuestion = question
    }
    
    private func checkAnswer(answer: Answers, question:Question) -> Bool{
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         
         
    }
    private func setUpQuestion (){
        gameModels.append(Question(text: "What is 2 + 2", answers:
                                    [Answers(text: "1", correct: false),
                                     Answers(text: "3", correct: false),
                                     Answers(text: "4", correct: true),
                                     Answers(text: "2", correct: false)
                                    ]))
        gameModels.append(Question(text: "What is 5 + 2", answers:
                                    [Answers(text: "8", correct: false),
                                     Answers(text: "7", correct: true),
                                     Answers(text: "3", correct: false),
                                     Answers(text: "6", correct: false)
                                    ]))
        gameModels.append(Question(text: "What is 5 * 2", answers:
                                    [Answers(text: "7", correct: false),
                                     Answers(text: "10", correct: true),
                                     Answers(text: "8", correct: false),
                                     Answers(text: "9", correct: false)
                                    ]))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let text = currentQuestion?.answers[indexPath.row].text
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentQuestion else {
            return
        }
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question){
            //correct
            if let index = gameModels.firstIndex(where: {$0.text == question.text}){
                if index < (gameModels.count - 1){
                    //next question
                    let nextQuestion = gameModels[index + 1]
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                    self.tableView.reloadData()
                    
                }
                else {
                    //end of game
                    let alert = UIAlertController(title: "Done", message: "You Win", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert,animated: true)
                }
            }
            
        }
        else {
            //wrong
            let alert = UIAlertController(title: "Wrong", message: "Try Again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
        
    }
}
