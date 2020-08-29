//
//  URLRequest.swift
//  
//
//  Created by Oliver Atkinson on 29/08/2020.
//

extension URLRequest {
    
    /// The cURL representation of the URLRequest, useful for debugging and executing requests outside of the app.
    public var cURLCommand: String {
        
        var command = "curl"
        
        if let httpMethod = httpMethod {
            command.append(commandLineArgument: "-X \(httpMethod)")
        }
        
        if let httpBody = httpBody, httpBody.count > 0 {

            let bodyString = [ ("\\", "\\\\"), ("`", "\\`"), ("\"", "\\\""), ("$", "\\$") ].reduce(String(data: httpBody, encoding: .utf8)) {
                return $0?.replacingOccurrences(of: $1.0, with: $1.1)
            }!

            command.append(commandLineArgument: "-d \"\(bodyString)\"")
            
        }
        
        if let acceptEncoderHeader = allHTTPHeaderFields?["Accept-Encoding"], (acceptEncoderHeader as NSString).range(of: "gzip").location != NSNotFound {
            command.append(commandLineArgument: "--compressed")
        }
        
        if let url = url, let cookies = HTTPCookieStorage.shared.cookies(for: url), cookies.count > 0 {
            
            let cookieCommand = cookies.map {
                "\($0.name)=\($0.value);"
            }.joined()
            
            command.append(commandLineArgument: "--cookie \"\(cookieCommand)\"")
            
        }
        
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            for (header, value) in allHTTPHeaderFields {
                command.append(commandLineArgument: "-H '\(header): \(value.replacingOccurrences(of: "\'", with: "\\\'"))'")
            }
        }
        
        if let url = url {
            command.append(commandLineArgument: "\"\(url.absoluteString)\"")
        }
        
        return command
        
    }
    
}

fileprivate extension String {
    
    mutating func append(commandLineArgument: String) {
        append(" \(commandLineArgument.trimmingCharacters(in: CharacterSet.whitespaces))")
    }
    
}
