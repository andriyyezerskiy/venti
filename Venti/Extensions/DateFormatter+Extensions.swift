//
//  DateFormatter+Extensions.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import Foundation

extension DateFormatter {
	
	static let shortDateFormat: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .none
		formatter.locale = .autoupdatingCurrent
		
		return formatter
	}()
	
	static let dayDateFormat: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = ""
		formatter.locale = .autoupdatingCurrent
		
		return formatter
	}()
}
