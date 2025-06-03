//
//  FinancialTransaction+CoreDataProperties.swift
//  
//
//  Created by Natália Arantes on 03/06/25.
//
//

import Foundation
import CoreData


extension FinancialTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinancialTransaction> {
        return NSFetchRequest<FinancialTransaction>(entityName: "FinancialTransaction")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var type: String?

}
