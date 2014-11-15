//
//  NVPlaceEntity.h
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CLLocation;

typedef NS_ENUM(NSInteger, NVTransitType) {
    NVTransitTypeByTrain,
    NVTransitTypeByFoot
};

@interface NVPlaceEntity : NSObject

/*
 @abstract 行き先の名前
 */
@property (nonatomic) NSString *placeName;

/*
 @abstract 行き先の説明情報。音声で読み上げる対象になる。
 */
@property (nonatomic) NSString *explanation;

/*
 @abstract 行き先の位置情報
 */
@property (nonatomic) CLLocation *location;

/*
 @abstract 行き先までの移動時間。
 */
@property (nonatomic) NSInteger transitTime;

/*
 @abstract 行き先までの行き方
 */
@property (nonatomic) NVTransitType transitType;

/*
 @abstract 移動の所要時間の文字列　（例：徒歩　１０分）
 */
@property (nonatomic,readonly) NSString *transitString;

/*
 @abstract 行き先の代表画像のURL
 */
@property (nonatomic) NSString *imageURL;

///*
// @abstract 行き先の代表画像そのもの
// */
//@property (nonatomic) UIImage *image;

@end
