//
//  News.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import UIKit

struct LatestNews: Codable {
    let date: String
    let stories: [Story]
    let topStories: [TopStory]
    
    enum CodingKeys: String, CodingKey {
        case date, stories
        case topStories = "top_stories"
    }
    
    init() {
        self.date = ""
        self.stories = []
        self.topStories = []
    }
}

struct Story: Codable {
    let imageHue, title: String
    let url: String
    let hint, gaPrefix: String
    let images: [String]
    let type, id: Int
    
    var inAppURL: URL { URL(string: "zhihudaily://story/\(id)")! }
    var image: String { images[0] }

    enum CodingKeys: String, CodingKey {
        case imageHue = "image_hue"
        case title, url, hint
        case gaPrefix = "ga_prefix"
        case images, type, id
    }
    
    init() {
        self.imageHue = ""
        self.title = ""
        self.url = ""
        self.hint = ""
        self.gaPrefix = ""
        self.images = []
        self.type = 0
        self.id = 0
    }
}

struct TopStory: Codable {
    let imageHue, hint: String
    let url: String
    let image: String
    let title, gaPrefix: String
    let type, id: Int
    
    var color: UIColor { hexStringToUIColor(hex: imageHue) }
    var inAppURL: URL { URL(string: "zhihudaily://topStory/\(id)")! }

    enum CodingKeys: String, CodingKey {
        case imageHue = "image_hue"
        case hint, url, image, title
        case gaPrefix = "ga_prefix"
        case type, id
    }
    
    // for preview test
    init(title: String, hint: String) {
        self.imageHue = ""
        self.title = title
        self.url = ""
        self.hint = hint
        self.gaPrefix = ""
        self.image = ""
        self.type = 0
        self.id = 0
    }
    
    init() {
        self.imageHue = ""
        self.title = ""
        self.url = ""
        self.hint = ""
        self.gaPrefix = ""
        self.image = ""
        self.type = 0
        self.id = 0
    }
}

func hexStringToUIColor(hex: String) -> UIColor {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }

    if cString.count != 6 {
        return UIColor.gray
    }

    var rgb: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgb)

    return UIColor(
        red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgb & 0x0000FF) / 255.0,
        alpha: 1.0
    )
}
