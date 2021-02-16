//
//  WSNewsHeadlineCommand.swift
//  
//
//  Created by Henri LA on 16.02.21.
//

import Foundation

public class WSNewsHeadlineCommand {

    // MARK: Parameters

    public var category: WSNewsCategory? {
        didSet {
            reset()
        }
    }

    public var country: WSNewsCountry? {
        didSet {
            reset()
        }
    }

    public var sources: String? {
        didSet {
            reset()
        }
    }

    public var query: String? {
        didSet {
            reset()
        }
    }

    private(set) public var page: Int = 0
    private(set) public var pageSize: Int

    // MARK: Inits

    public init(pageSize: Int = 20) {
        self.pageSize = pageSize
    }

    public init(savedCommand: WSNewsHeadlineSavedCommand) {
        category = savedCommand.category
        country = savedCommand.country
        sources = savedCommand.sources
        query = savedCommand.query
        page = savedCommand.page
        pageSize = savedCommand.pageSize
    }

    // MARK: Private func

    private func reset() {
        page = 0
    }

    // MARK: Public functions

    public func nextPage() -> RequestBuilder<WSNewsTopHeadlineResponse> {
        page += 1
        return WSNewsAPI.topHeadlinesGetWithRequestBuilder(q: query,
                                                           sources: sources,
                                                           country: country,
                                                           category: category,
                                                           page: page,
                                                           pageSize: pageSize)
    }

    public func savedCommand() -> WSNewsHeadlineSavedCommand {
        return WSNewsHeadlineSavedCommand(category: category,
                                          country: country,
                                          sources: sources,
                                          query: query,
                                          page: page,
                                          pageSize: pageSize)
    }

}

public struct WSNewsHeadlineSavedCommand: Codable {
    let category: WSNewsCategory?
    let country: WSNewsCountry?
    let sources: String?
    let query: String?
    let page: Int
    let pageSize: Int
}
