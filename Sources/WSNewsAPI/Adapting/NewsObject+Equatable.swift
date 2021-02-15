//
//  File.swift
//  
//
//  Created by Henri LA on 15.02.21.
//

import Foundation

extension WSNewsSource: Equatable {

    public static func == (lhs: WSNewsSource, rhs: WSNewsSource) -> Bool {
        return lhs._id == rhs._id &&
            lhs.name == rhs.name
    }

}

extension WSNewsArticle: Equatable {
    public static func == (lhs: WSNewsArticle, rhs: WSNewsArticle) -> Bool {
        return lhs.source == rhs.source &&
            lhs.url == rhs.url &&
            lhs.author == rhs.author &&
            lhs.description == rhs.description &&
            lhs.title == rhs.title
    }
}
