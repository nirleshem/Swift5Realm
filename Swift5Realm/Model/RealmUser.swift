//
//  RealmUser.swift
//  Swift5Realm
//
//  Created by Nir Leshem on 09/01/2021.
//

import Foundation
import RealmSwift

@objcMembers class RealmUser: Object {

    // Must not forget dynamic before each parameter.
    // + @objcMembers on the class or @objc before each parameter.
    
    dynamic var id: Int? = nil
    dynamic var name: String? = nil
    dynamic var username: String? = nil
    dynamic var email: String? = nil
    dynamic var address: AddressRealm? = nil
    dynamic var phone: String? = nil
    dynamic var website: String? = nil
    dynamic var company: CompanyRealm? = nil
    
    convenience init(_ apiUser: APIUser) {
        self.init()
        id = apiUser.id
        name = apiUser.name
        username = apiUser.username
        email = apiUser.email
        address = .init(apiUser.address)
        phone = apiUser.phone
        website = apiUser.website
        company = .init(apiUser.company)
    }
}

// MARK: - Address
@objcMembers class AddressRealm: Object {
    dynamic var street: String? = nil
    dynamic var suite: String? = nil
    dynamic var city: String? = nil
    dynamic var zipcode: String? = nil
    dynamic var geo: GeoRealm? = nil

    convenience init(_ address: Address?) {
        self.init()
        guard let address = address else { return }
        street = address.street
        suite = address.suite
        city = address.city
        zipcode = address.zipcode
        geo = .init(address.geo)
    }
}

// MARK: - Geo
@objcMembers class GeoRealm: Object {
    dynamic var lat: String? = nil
    dynamic var lng: String? = nil
    
    convenience init(_ geo: Geo?) {
        self.init()
        guard let geo = geo else { return }
        lat = geo.lat
        lng = geo.lng
    }
}

// MARK: - Company
@objcMembers class CompanyRealm: Object {
    dynamic var name: String? = nil
    dynamic var catchPhrase: String? = nil
    dynamic var bs: String? = nil

    convenience init(_ company: Company?) {
        self.init()
        guard let company = company else { return }
        name = company.name
        catchPhrase = company.catchPhrase
        bs = company.bs
    }
}
