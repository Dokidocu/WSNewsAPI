//
//  WSNewsArticlesCommand.swift
//  
//
//  Created by Henri LA on 16.02.21.
//

import Foundation

public class WSNewsArticlesCommand {

    // MARK: Parameters

    public var query: String? {
        didSet {
            reset()
        }
    }

    public var qInTitle: String? {
        didSet {
            reset()
        }
    }

    public var sources: String? {
        didSet {
            reset()
        }
    }

    public var domains: String? {
        didSet {
            reset()
        }
    }

    public var excludeDomains: String? {
        didSet {
            reset()
        }
    }

    public var from: Date? {
        didSet {
            reset()
        }
    }

    public var to: Date? {
        didSet {
            reset()
        }
    }

    public var language: WSNewsLanguage? {
        didSet {
            reset()
        }
    }

    public var sortBy: WSNewsSortBy? {
        didSet {
            reset()
        }
    }

    private(set) public var page: Int = 0
    private(set) public var pageSize: Int

    // MARK: Private

    private func reset() {
        page = 0
    }

    // MARK: Inits

    public init(pageSize: Int = 20) {
        self.pageSize = pageSize
    }

    public init(savedCommand: WSNewsArticlesSavedCommand) {
        query = savedCommand.query
        qInTitle = savedCommand.qInTitle
        sources = savedCommand.sources
        domains = savedCommand.domains
        excludeDomains = savedCommand.excludeDomains
        from = savedCommand.from
        to = savedCommand.to
        language = savedCommand.language
        sortBy = savedCommand.sortBy
        page = savedCommand.page
        pageSize = savedCommand.pageSize
    }

    // MARK: Public function

    public func nextPage() -> RequestBuilder<WSNewsTopHeadlineResponse> {
        page += 1
        return WSNewsAPI.everythingGetWithRequestBuilder(page: page,
                                                         pageSize: pageSize,
                                                         q: query,
                                                         qInTitle: qInTitle,
                                                         sources: sources,
                                                         domains: domains,
                                                         excludeDomains: excludeDomains,
                                                         from: from,
                                                         to: to,
                                                         language: language,
                                                         sortBy: sortBy)
    }

    public func savedCommand() -> WSNewsArticlesSavedCommand {
        return WSNewsArticlesSavedCommand(query: query,
                                          qInTitle: qInTitle,
                                          sources: sources,
                                          domains: domains,
                                          excludeDomains: excludeDomains,
                                          from: from,
                                          to: to,
                                          language: language,
                                          sortBy: sortBy,
                                          page: page,
                                          pageSize: pageSize)
    }

}

public struct WSNewsArticlesSavedCommand: Codable {
    let query: String?
    let qInTitle: String?
    let sources: String?
    let domains: String?
    let excludeDomains: String?
    let from: Date?
    let to: Date?
    let language: WSNewsLanguage?
    let sortBy: WSNewsSortBy?

    let page: Int
    let pageSize: Int
}
