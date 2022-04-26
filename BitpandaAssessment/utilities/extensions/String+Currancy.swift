//
//  String+Currancy.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation

extension String {
    func toCurrancy(precision: Int, currencyCode: String = "EUR", currencySymbol:String = "EUR") -> String {
        let nsnumberValue = NSNumber(value: Double(self) ?? 0)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = currencyCode
//        numberFormatter.currencySymbol =  currencySymbol
        numberFormatter.maximumFractionDigits = precision
        return numberFormatter.string(from: nsnumberValue) ?? ""
    }
}
