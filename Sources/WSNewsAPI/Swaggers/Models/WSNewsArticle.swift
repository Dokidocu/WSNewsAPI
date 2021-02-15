//
// WSNewsArticle.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct WSNewsArticle: Codable {

    public var source: WSNewsSource?
    /** The author of the article */
    public var author: String?
    /** The headline or title of the article. */
    public var title: String?
    /** A description or snippet from the article. */
    public var _description: String?
    /** The direct URL to the article. */
    public var url: String?
    /** The URL to a relevant image for the article. */
    public var urlToImage: String?
    /** The date and time that the article was published, in UTC (+000) */
    public var publishedAt: String?
    /** The unformatted content of the article, where available. This is truncated to 200 chars. */
    public var content: String?

    public init(source: WSNewsSource? = nil, author: String? = nil, title: String? = nil, _description: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.source = source
        self.author = author
        self.title = title
        self._description = _description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }

    public enum CodingKeys: String, CodingKey { 
        case source
        case author
        case title
        case _description = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }

}
