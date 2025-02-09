//  HashtagTimelineQuery.swift
//  Created by Konstantin on 09/03/2023.

import Foundation

/// Specifies the parameters for a hashtag timeline request
public struct HashtagTimelineQuery: Codable, Sendable {

    public init(tag: String, anyTags: [String]? = nil, allTags: [String]? = nil, noneTags: [String]? = nil, onlyMedia: Bool? = nil, local: Bool? = nil, remote: Bool? = nil) {
        self.tag = tag
        self.anyTags = anyTags
        self.allTags = allTags
        self.noneTags = noneTags
        self.onlyMedia = onlyMedia
        self.local = local
        self.remote = remote
    }

    /// The name of the hashtag, not including the `#` symbol
    public var tag: String

    /// Return posts that contain any of these additional tags
    public var anyTags: [String]?

    /// Return posts that contain all of these additional tags
    public var allTags: [String]?

    /// Return posts that contain none of these additional tags
    public var noneTags: [String]?

    /// Return only posts with media attachments
    public var onlyMedia: Bool?

    /// Return only local posts
    public var local: Bool?

    /// Return only remote posts
    public var remote: Bool?
}

extension HashtagTimelineQuery: TimelineQuery {

    public func getQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []

        if let anyTags {
            queryItems.append(contentsOf: anyTags.map({ URLQueryItem(name: "any[]", value: $0) }))
        }
        if let allTags {
            queryItems.append(contentsOf: allTags.map({ URLQueryItem(name: "all[]", value: $0) }))
        }
        if let noneTags {
            queryItems.append(contentsOf: noneTags.map({ URLQueryItem(name: "none[]", value: $0) }))
        }

        if let onlyMedia {
            queryItems.append(.init(name: "only_media", value: String(onlyMedia)))
        }

        if let local {
            queryItems.append(.init(name: "local", value: String(local)))
        }

        if let remote {
            queryItems.append(.init(name: "remote", value: String(remote)))
        }

        return queryItems
    }

}
