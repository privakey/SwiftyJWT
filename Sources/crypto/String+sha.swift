//
//  String+sha.swift
//  SwiftyJWT
//
//  Created by Joseph Fischetti on 5/30/18.
//  Copyright © 2018 Yufu. All rights reserved.
//

import Foundation
import CCommonCrypto

public extension String {
    public func sha512() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA512_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA512($0, CC_LONG(data.count), &digest)
        }
        return Data(bytes: digest).base64EncodedString()
    }
}
