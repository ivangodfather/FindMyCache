//
//  APIClient.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 10/1/24.
//

import Foundation

import AuthenticationServices

struct CreateUserRequestParams: Encodable {
  let email: String
  let username: String
  let avatarData: Data?
  let appleAuth: User.AppleAuth?
  
  init(email: String, username: String, avatarData: Data?, authorizationCredential: ASAuthorizationAppleIDCredential) {
    self.email = email
    self.username = username
    self.avatarData = avatarData
    appleAuth = .init(
      appleIdentifier: authorizationCredential.user,
      appleIdentityToken: authorizationCredential.identityToken.utf8,
      appleAuthorizationCode: authorizationCredential.authorizationCode.utf8,
      realUserStatus: authorizationCredential.realUserStatus.description
    )
  }
}

import ComposableArchitecture
@DependencyClient
struct APIClient {
  var createUser: @Sendable (CreateUserRequestParams) async throws -> User
}

extension APIClient: TestDependencyKey {
  static let previewValue = Self(
    createUser: { _ in .mock }
  )
  
  static let testValue = Self()
}

extension APIClient: DependencyKey {
  static let liveValue = APIClient(
    createUser: { params in
      let request = FindMyCacheEndpoint.createUser(params).request
      let (data, response) = try await URLSession.shared.data(for: request)
      if let debugData = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
        print("API Response (\((response as! HTTPURLResponse).statusCode)):\n")
        print(response.debugDescription)
        debugPrint(debugData, terminator: "\n\n")
      }
      return try JSONDecoder().decode(User.self, from: data)
    }
  )
}

extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}


enum FindMyCacheEndpoint: Endpoint {
  case createUser(CreateUserRequestParams)
  
  var path: String {
    switch self {
    case .createUser:
      return "user"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .createUser:
      return .post
    }
  }
  
  var requestBody: Data? {
    switch self {
    case .createUser(let params):
      return params.encodeToJSON
    }
  }
  
  var serverURL: URL {
    switch self {
    case .createUser:
      return URL(string: "http://localhost:3000/api/v1/")!
    }
  }
  
  var headers: [String: String] {
      [
          "Content-Type": "application/json",
      ]
  }
  
  var queryParameters: [String : String]? { [:] }
  
  var request: URLRequest {
    var urlComponents = URLComponents(url: serverURL.appendingPathComponent(path).absoluteURL, resolvingAgainstBaseURL: true) ?? URLComponents()
    urlComponents.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = method.rawValue.uppercased()
    request.httpBody = requestBody
    
    headers.forEach {
      request.addValue($0.value, forHTTPHeaderField: $0.key)
    }
    return request
  }
}

protocol Endpoint {
  var path: String { get }
  var method: HTTPMethod { get }
  var requestBody: Data? { get }
  var serverURL: URL { get }
  var headers: [String: String] { get }
  var queryParameters: [String: String]? { get }
}

enum HTTPMethod: String {
  case delete
  case get
  case patch
  case post
  case put
}
