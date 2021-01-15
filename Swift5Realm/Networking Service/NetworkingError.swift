//
//  NetworkingError.swift
//  Swift5Realm
//
//  Created by Nir Leshem on 09/01/2021.
//

import Foundation

public enum NetworkingError: Error {
    /// Unknown or not supported error.
    case Unknown
    
    /// Bad URL reveived.
    case BadURL
    
    /// Request timed out.
    case TimedOut
    
    /// Not connected to the internet.
    case NotConnectedToInternet
    
    /// Parsing problem.
    case CannotParseResponse
    
    /// International data roaming turned off.
    case InternationalRoamingOff
    
    /// Cannot reach the server.
    case NotReachedServer
    
    /// Connection is lost.
    case ConnectionLost
    
    /// Incorrect data returned from the server.
    case IncorrectDataReturned
    
    /// Data size exceeds maximum.
    case DataLengthExceedsMaximum
    
    /// Status cade is not 200
    case ErrorStatusCode
    
    internal init(error: Error) {
        if error._domain == NSURLErrorDomain {
            switch error._code {
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorBadURL,
                 NSURLErrorUnsupportedURL:
                self = .BadURL
            case NSURLErrorTimedOut:
                self = .TimedOut
            case NSURLErrorInternationalRoamingOff:
                self = .InternationalRoamingOff
            case NSURLErrorCannotParseResponse:
                self = .CannotParseResponse
            case NSURLErrorDataLengthExceedsMaximum:
                self = .DataLengthExceedsMaximum
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            case NSURLErrorCannotFindHost,
                 NSURLErrorCannotConnectToHost,
                 NSURLErrorDNSLookupFailed:
                self = .NotReachedServer
            case NSURLErrorResourceUnavailable,
                 NSURLErrorRedirectToNonExistentLocation,
                 NSURLErrorBadServerResponse,
                 NSURLErrorZeroByteResource,
                 NSURLErrorCannotDecodeRawData,
                 NSURLErrorCannotDecodeContentData,
                 NSURLErrorFileDoesNotExist,
                 NSURLErrorFileIsDirectory:
                self = .IncorrectDataReturned
            case NSURLErrorUnknown,
                 NSURLErrorCancelled,
                 NSURLErrorHTTPTooManyRedirects,
                 NSURLErrorUserCancelledAuthentication,
                 NSURLErrorUserAuthenticationRequired,
                 NSURLErrorCallIsActive,
                 NSURLErrorDataNotAllowed,
                 NSURLErrorRequestBodyStreamExhausted,
                 NSURLErrorNoPermissionsToReadFile,
                 NSURLErrorSecureConnectionFailed,
                 NSURLErrorServerCertificateHasBadDate,
                 NSURLErrorServerCertificateUntrusted,
                 NSURLErrorServerCertificateHasUnknownRoot,
                 NSURLErrorServerCertificateNotYetValid,
                 NSURLErrorClientCertificateRejected,
                 NSURLErrorClientCertificateRequired,
                 NSURLErrorCannotLoadFromNetwork,
                 NSURLErrorCannotCreateFile,
                 NSURLErrorCannotOpenFile,
                 NSURLErrorCannotCloseFile,
                 NSURLErrorCannotWriteToFile,
                 NSURLErrorCannotRemoveFile,
                 NSURLErrorCannotMoveFile,
                 NSURLErrorDownloadDecodingFailedMidStream,
                 NSURLErrorDownloadDecodingFailedToComplete:
                self = .Unknown
            default:
                self = .Unknown
            }
        }
        else {
            self = .Unknown
        }
    }
}
