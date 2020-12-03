//
//  Line.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/23.
//

import Foundation
import CoreGraphics


struct Line: Codable {
    var begin = CGPoint.zero
    var end = CGPoint.zero
    
    enum CodingKeys: String, CodingKey {
        case begin
        case end
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(begin, forKey: .begin)
        try container.encode(end, forKey: .end)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        begin = try container.decode(CGPoint.self, forKey: .begin)
        end = try container.decode(CGPoint.self, forKey: .end)
    }
    
    init(begin: CGPoint, end: CGPoint){
        self.begin = begin
        self.end = end
    }
}
