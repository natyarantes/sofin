//
//  TransactionsRepository.swift
//  sofin
//
//  Created by Natália Arantes on 16/08/25.
//

import Foundation

protocol TransactionsRepository {
    func fetchTransactions(in interval: DateInterval) throws -> [Transaction]
}

