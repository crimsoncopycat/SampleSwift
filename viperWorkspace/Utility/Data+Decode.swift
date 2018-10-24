//
//  Data+Decode.swift
//  QuizQuestionsYoungOldProject
//
//  Created by Jworld Downloads on 6/11/18.
//
import Foundation
public extension Decodable {
    public static func decode<T>(_ input: T) throws -> Self {
        guard let data = Data.generic(input) else {
            fatalError("need to convert \(type(of: input)) type to data")
        }

        return try JSONDecoder().decode(Self.self, from: data)
    }
}

public extension Data {
    public static func generic<T>(_ input: T) -> Data? {
        if let data = input as? Data {
            return data
        }
        
        if let string = input as? String {
            return string.data(using: .utf8)
        }
        
        if let url = input as? URL {
            return try? Data(contentsOf: url)
        }
        
        fatalError("need to add \(type(of: input)) to data to this function")
    }
}

