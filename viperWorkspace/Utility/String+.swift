//
//  String+.swift
//  QuizQuestionsYoungOldProject
//
//  Created by Jworld Downloads on 7/18/18.
//

import Foundation

extension String {
    func totalOccurenceofCharInString(char: Character) -> Int{
        return self.filter { $0 == char }.count
    }
}
