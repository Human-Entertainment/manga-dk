//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 20/01/2020.
//

import Plot
import Vapor

extension HTML: ResponseEncodable {
    public func encodeResponse(for req: Request) -> EventLoopFuture<Response> {
        let res = Response(headers: ["content-type": "text/html; charset=utf-8"], body: Response.Body(string: self.render()))
        return res.encodeResponse(for: req)
    }
    
    public func encodeResponse(for request: Request) -> EventLoopFuture<HTML> {
        request.eventLoop.submit{self}
    }
}
