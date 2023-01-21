//
//  Expense.swift
//  Budget
//
//  Created by Алексей Зарицький on 20.01.2023.
//

import SwiftUI

// MARK: Expense Model with Sample Data
struct Expense: Identifiable{
    var id: UUID = .init()
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense(amountSpent: "$350", product: "Amazon", productIcon: "Amazon", spendType: "Groceries"),
    Expense(amountSpent: "$18", product: "Youtube", productIcon: "Youtube", spendType: "Streaming"),
    Expense(amountSpent: "$10", product: "Dribbble", productIcon: "Dribbble", spendType: "Membership"),
    Expense(amountSpent: "$1500", product: "Apple", productIcon: "Apple", spendType: "Apple Pay"),
    Expense(amountSpent: "$15", product: "Mcdonalds", productIcon: "Mcdonalds", spendType: "restaurant"),
    Expense(amountSpent: "$5", product: "Instagram", productIcon: "Instagram", spendType: "Ad Publish"),
    Expense(amountSpent: "$12", product: "Netflix", productIcon: "Netflix", spendType: "Movies"),
    Expense(amountSpent: "$348", product: "Photoshop", productIcon: "Photoshop", spendType: "Editing"),
    Expense(amountSpent: "$10", product: "Figma", productIcon: "Figma", spendType: "Pro Member"),
]
