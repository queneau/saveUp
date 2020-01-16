//
//  ViewController.swift
//  saveUp
//
//  Created by kno on 2020/01/13.
//  Copyright © 2020 kno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var addWeekEnd: UILabel!

    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var inputAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初期値何も表示させない
        weekDay.text = ""
        addWeekEnd.text = ""
        errorMessage.text = ""
        //Text Fieldのdelegate通知を設定
        inputAmount.delegate = self
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        //初期値0なのでOptionalではない
        var intAmount = 0
//        //nilなら0入れる，そうでなければ入力値
//        if Int(inputAmount.text!) == nil {
//            intAmount = 0
//        } else {
//            intAmount = Int(inputAmount.text!)!
//        }
        if inputAmount.text == "" {
            errorMessage.text = "入力してください"
            return
        }
        if let amount = Int(inputAmount.text!) {
            if(amount > 10000) {
                errorMessage.text = "使いすぎ"
                return
            }
            if(amount < 0) {
                errorMessage.text = "正の整数を入力してください"
                return
            }
            intAmount = amount
        } else {
            errorMessage.text = "有効な数値を入力してください"
            return
        }
        // let intAmount = Int(inputAmount.text!)
        weekDay.text = weekDayCalc(intAmount)
        addWeekEnd.text = addWeekEndCalc(intAmount)
    }
    
    //平日のみ計算
    private func weekDayCalc(_ amount: Int) -> String{
            let result = amount * 5 * (365 / 7)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let commaResult = formatter.string(from: result as NSNumber)
            return commaResult!.description
    }

    //週末含め計算
    private func addWeekEndCalc(_ amount: Int) -> String{
        let result = amount * 365
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let commaResult = formatter.string(from: result as NSNumber)
        return commaResult!.description
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボード閉じる, returnボタンで判定
        textField.resignFirstResponder()
        return true
    }
    
    

}
