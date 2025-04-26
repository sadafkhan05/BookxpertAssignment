//
//  HomeDataModal.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 26/04/25.
//

import Foundation

struct HomeDataModel: Codable {
    let id: String?
    let name: String?
    let data: DeviceDetails?
}

struct DeviceDetails: Codable {
    let color: String?
    let capacity: String?
}
