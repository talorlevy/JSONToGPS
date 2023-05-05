//
//  AddressModel.swift
//  JSONToGPS
//
//  Created by Talor Levy on 2/17/23.
//

import Foundation

struct AddressModel: Codable {
    var city: String?
    var geo: GeoModel?
}
