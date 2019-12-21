//
//  ResponseDataModel.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import Foundation

// MARK: - ResponseDataModel
struct ResponseDataModel: Codable {
    let skuId,skuName,brandName,categoryName,deliveryTitle,parentCategoryName,superCategoryName: String?
    let defaultPrice,listPrice,skuAverageRating: Double?
    let skuReviewCount: Int?
    let cleanBeauty: CleanBeauty?
    let skuImageUrls: [String]?
    let variants: Variants?
    let facets: [Facets]?
    let productCombo: [ProductCombo]?
    let reviews: [Reviews]?
    let qna: [QnA]?
    let deepLinkUrl: String?
}

// MARK: - CleanBeauty
struct CleanBeauty: Codable {
    let subTitle, title: String?
    let imageUrls: [String]?
}

// MARK: - Variants
struct Variants: Codable {
    
    let volume: [Volume]?
}

struct Volume: Codable {
    let volume: String?
    let isSelected: Bool?
}

struct Facets: Codable {
    let type,title,content: String?
}

struct ProductCombo: Codable {
    
    struct Sku1: Codable {
        let skuId,skuName,skuImageUrl,categoryName,parentCategoryName,superCategoryName: String?
        let defaultPrice,listPrice,skuAverageRating: Double?
    }
    
    struct Sku2: Codable {
        let skuId,skuName,skuImageUrl,categoryName,parentCategoryName,superCategoryName: String?
        let defaultPrice,listPrice,skuAverageRating: Double?
    }
    
    let defaultPrice,listPrice: String?
    let sku1: Sku1?
    let sku2: Sku2?
}

struct QnA: Codable {
    
    struct Answer: Codable {
        let userNickname,answerText: String?
        let postedDate: Double?
    }
    
    let userNickname,queryText: String?
    let postedDate: Double?
    let answer: Answer?
    
}

struct Reviews: Codable {
    let userNickname,reviewTitle,reviewText: String?
    let postedDate,skuRating: Double?
}
