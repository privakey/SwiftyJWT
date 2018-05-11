//
//  JWTHeader.swift
//  SwiftyJWT
//
//  Created by Shuo Wang on 2018/1/17.
//  Copyright © 2018年 Yufu. All rights reserved.
//

import Foundation

public struct JWTHeader: Codable {
    // Registered Claim Names
    // alg
    public var algorithm: String?
    // typ
    public var type: String = "JWT"
    // kid
    public var keyId: String?
    // custom fields
    public var customFields: [String: EncodableValue]?
    
    public init(keyId: String? = nil) {
        self.keyId = keyId
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        algorithm = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.algorithm.rawValue))
        keyId = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.keyId.rawValue))
        type = (try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.type.rawValue)))!
        let customKeys = container.allKeys
            .filter({ !JWTHeader.reservedKeys.contains($0.stringValue) })
        if 0 < customKeys.count {
            customFields = [:]
            for key in customKeys {
                customFields![key.stringValue] = try container.decodeIfPresent(EncodableValue.self, forKey: key)
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicKey.self)
        try container.encodeIfPresent(algorithm, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.algorithm.rawValue))
        try container.encodeIfPresent(keyId, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.keyId.rawValue))
        try container.encodeIfPresent(type, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.type.rawValue))
        if let fields = customFields {
            for (key, value) in fields {
                let codingKey = DynamicKey(stringValue: key)
                try container.encodeIfPresent(value, forKey: codingKey)
            }
        }
    }
    
    public static let reservedKeys = ["alg", "kid", "typ"]

    enum JWTHeaderCodingKeys: String {
        case algorithm = "alg"
        case keyId = "kid"
        case type = "typ"
    }
}
