//
//  Calculator.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation

struct Calculator {
    func sumOfNums(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else {
            return 0
        }
        return num1 + num2
    }
    
    func subtractionOfNums(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else {
            return 0
        }
        return num1 - num2
    }
    
    func multiplicationOfNums(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else {
            return 0
        }
        return num1 * num2
    }
    
    func divisonOfNums(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2, num2 != 0 else {
            return 0
        }
        return num1 / num2
    }
}
