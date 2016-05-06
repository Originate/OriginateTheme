//
//  OriginateThemeComponents.h
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

@import UIKit;

#import "UIColor+OriginateThemeHex.h"

@interface OriginateThemeComponents : NSObject

#pragma mark - Properties
// Navigation Bar
@property (nonatomic, strong, readwrite) UIColor *navigationBarBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *navigationBarTextColor;

// Tab Bar
@property (nonatomic, strong, readwrite) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *tabBarTextColor;
@property (nonatomic, strong, readwrite) UIColor *tabBarSelectedTextColor;

// Buttons
@property (nonatomic, strong, readwrite) UIColor *buttonPlainBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *buttonPlainTextColor;

@property (nonatomic, strong, readwrite) UIColor *buttonDestructiveBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *buttonDestructiveTextColor;

@property (nonatomic, strong, readwrite) UIColor *buttonActionableBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *buttonActionableTextColor;

// Table View
@property (nonatomic, strong, readwrite) UIColor *tableViewBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *tableViewSeparatorColor;

// Table View Cells
@property (nonatomic, strong, readwrite) UIColor *tableViewCellBackgroundColor;

@property (nonatomic, strong, readwrite) UIColor *tableViewCellSelectedBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *tableViewCellHighlightedBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *tableViewCellTextColor;
@property (nonatomic, strong, readwrite) UIColor *tableViewCellSelectedTextColor;
@property (nonatomic, strong, readwrite) UIColor *tableViewCellHighlightedTextColor;

// Collection View
@property (nonatomic, strong, readwrite) UIColor *collectionViewBackgroundColor;

@property (nonatomic, strong, readwrite) UIColor *collectionViewCellBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *collectionViewCellSelectedBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *collectionViewCellHighlightedBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *collectionViewCellTextColor;
@property (nonatomic, strong, readwrite) UIColor *collectionViewCellSelectedTextColor;
@property (nonatomic, strong, readwrite) UIColor *collectionViewCellHighlightedTextColor;

// View
@property (nonatomic, strong, readwrite) UIColor *viewBackgroundColor;

#pragma mark - Methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
