//
// WSNewsErrorResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct WSNewsErrorResponse: Codable {

    /** If the request was successful or not. Options: ok, error. In the case of ok, the below two properties will not be present. */
    public var status: String?
    /** A short code identifying the type of error returned. */
    public var code: String?
    /** A fuller description of the error, usually including how to fix it. */
    public var message: String?

    public init(status: String? = nil, code: String? = nil, message: String? = nil) {
        self.status = status
        self.code = code
        self.message = message
    }


}
