//
//  MarvelFetcher.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/23/21.
//

import Foundation
import Combine

protocol MarvelFetchable {
    func fetchCharacters(offset: Int) -> AnyPublisher<ApiResponse, MarvelError>
}

class MarvelFetcher {
    private let session: URLSession
    var marvelPublicKey: String? = nil
    var marvelPrivateKey: String? = nil
    var marvelHost: String? = nil

    init(session: URLSession = .shared) {
        self.session = session
        
        let configurations = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist")!)!
        
        // Not a best practice to keep those API keys in the plist, but...
        guard let publicKey = configurations[apiPublicKey] as! String?,
              let privateKey = configurations[apiPrivateKey] as! String?,
              let hostKey = configurations[apiHostKey] as! String? else {
            return
        }
        
        marvelPublicKey = publicKey
        marvelPrivateKey = privateKey
        marvelHost = hostKey
    }
}

// MARK: - MarvelFetchable
extension MarvelFetcher: MarvelFetchable {
    func fetchCharacters(offset: Int = 0) -> AnyPublisher<ApiResponse, MarvelError> {
        return download(with: makeAllCharactersComponents(offset: offset))
    }

    private func download<T>(with components: URLComponents?) -> AnyPublisher<T, MarvelError> where T: Decodable {
        guard let components = components,
              let url = components.url else {
            let error = MarvelError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
            .network(description: error.localizedDescription)
            }
            .flatMap() { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }

    private func allKeysValid() -> Bool {
        return self.marvelPublicKey != nil &&
                self.marvelPrivateKey != nil &&
                self.marvelHost != nil
    }
    
    private func makeHash(with timeStamp: UInt64) -> String? {
        guard allKeysValid() else {
            return nil
        }
        
        return "\(timeStamp)\(marvelPrivateKey!)\(marvelPublicKey!)".md5Hash
    }
}

// MARK: - MarvelMap API
private extension MarvelFetcher {
    func makeAllCharactersComponents(offset: Int = 0) -> URLComponents? {
        let timeStamp = UInt64(Date().timeIntervalSince1970)
        var components = URLComponents()

        guard let hash = makeHash(with: timeStamp) else {
            return nil
        }
        
        components.scheme = marvelScheme
        components.host = marvelHost!
        components.path = "/v1/public/\(marvelCharacterPath)"

        components.queryItems = [
            URLQueryItem(name: "apikey", value: marvelPublicKey),
            URLQueryItem(name: "ts", value: String(timeStamp)),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "limit", value: String(kMaxDownload)),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]

        return components
    }
}
