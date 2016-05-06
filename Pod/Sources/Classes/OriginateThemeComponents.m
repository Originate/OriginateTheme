//
//  OriginateThemeComponents.m
//  OriginateUI
//
//  Created by Philip Kluz on 2016-05-06.
//  Copyright (c) 2016 Originate. All rights reserved.
//

#import "OriginateThemeComponents.h"

NSString * const OUINavigationBarBackgroundColorKeyPath = @"navigationBar.backgroundColor";
NSString * const OUINavigationBarTextColorKeyPath = @"navigationBar.textColor";
NSString * const OUITabBarBackgroundColorKeyPath = @"tabBar.backgroundColor";
NSString * const OUITabBarTextColorKeyPath = @"tabBar.textColor";
NSString * const OUITabBarSelectedTextColorKeyPath = @"tabBar.selectedTextColor";

NSString * const OUIButtonPlainBackgroundColorKeyPath = @"button.plain.backgroundColor";
NSString * const OUIButtonPlainTextColorKeyPath = @"button.plain.textColor";
NSString * const OUIButtonDestructiveBackgroundColorKeyPath = @"button.destructive.backgroundColor";
NSString * const OUIButtonDestructiveTextColorKeyPath = @"button.destructive.textColor";
NSString * const OUIButtonActionableBackgroundColorKeyPath = @"button.actionable.backgroundColor";
NSString * const OUIButtonActionableTextColorKeyPath = @"button.actionable.textColors";

NSString * const OUITableViewBackgroundColorKeyPath = @"tableView.backgroundColor";
NSString * const OUITableViewSeparatorColorKeyPath = @"tableView.separatorColor";

NSString * const OUITableViewCellBackgroundColorKeyPath = @"tableView.cell.backgroundColor";
NSString * const OUITableViewCellSelectedBackgroundColorKeyPath = @"tableView.cell.selectedBackgroundColor";
NSString * const OUITableViewCellHighlightedBackgroundColorKeyPath = @"tableView.cell.highlightedBackgroundColor";
NSString * const OUITableViewCellTextColorKeyPath = @"tableView.cell.textColor";
NSString * const OUITableViewCellSelectedTextColorKeyPath = @"tableView.cell.selectedTextColor";
NSString * const OUITableViewCellHighlightedTextColorKeyPath = @"tableView.cell.highlightedTextColor";

NSString * const OUICollectionViewBackgroundColorKeyPath = @"collectionView.backgroundColor";

NSString * const OUICollectionViewCellBackgroundColorKeyPath = @"collectionView.cell.backgroundColor";
NSString * const OUICollectionViewCellSelectedBackgroundColorKeyPath = @"collectionView.cell.selectedBackgroundColor";
NSString * const OUICollectionViewCellHighlightedBackgroundColorKeyPath = @"collectionView.cell.highlightedBackgroundColor";
NSString * const OUICollectionViewCellTextColorKeyPath = @"collectionView.cell.textColor";
NSString * const OUICollectionViewCellSelectedTextColorKeyPath = @"collectionView.cell.selectedTextColor";
NSString * const OUICollectionViewCellHighlightedTextColorKeyPath = @"collectionView.cell.highlightedTextColor";

NSString * const OUIViewBackgroundColorKeyPath = @"view.backgroundColor";

@interface OriginateThemeComponents ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSDictionary *definition;

@end

@implementation OriginateThemeComponents

#pragma mark - OriginateThemeComponents

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        _definition = dictionary;
    }
    
    return self;
}

+ (UIColor *)colorForKeyPath:(NSString *)keyPath
                      source:(NSDictionary *)definition
                    fallback:(UIColor *)fallback
{
    NSString *colorValue = [definition valueForKeyPath:keyPath];
    
    if ([colorValue length] == 0) {
        return fallback;
    }
    
    UIColor *color = [UIColor oth_colorWithHexString:colorValue];
    
    return color ?: fallback;
}

#pragma mark - Navigation Bar

- (UIColor *)navigationBarBackgroundColor
{
    if (!_navigationBarBackgroundColor) {
        _navigationBarBackgroundColor = [[self class] colorForKeyPath:OUINavigationBarBackgroundColorKeyPath
                                                               source:self.definition
                                                             fallback:[UIColor whiteColor]];
    }
    
    return _navigationBarBackgroundColor;
}

- (UIColor *)navigationBarTextColor
{
    if (!_navigationBarTextColor) {
        _navigationBarTextColor = [[self class] colorForKeyPath:OUINavigationBarTextColorKeyPath
                                                         source:self.definition
                                                       fallback:[UIColor darkGrayColor]];
    }
    
    return _navigationBarTextColor;
}

#pragma mark - Tab Bar

- (UIColor *)tabBarBackgroundColor
{
    if (!_tabBarBackgroundColor) {
        _tabBarBackgroundColor = [[self class] colorForKeyPath:OUITabBarBackgroundColorKeyPath
                                                        source:self.definition
                                                      fallback:[UIColor whiteColor]];
    }
    
    return _tabBarBackgroundColor;
}

- (UIColor *)tabBarTextColor
{
    if (!_tabBarTextColor) {
        _tabBarTextColor = [[self class] colorForKeyPath:OUITabBarTextColorKeyPath
                                                  source:self.definition
                                                fallback:[UIColor lightGrayColor]];
    }
    
    return _tabBarTextColor;
}

- (UIColor *)tabBarSelectedTextColor
{
    if (!_tabBarSelectedTextColor) {
        _tabBarSelectedTextColor = [[self class] colorForKeyPath:OUITabBarSelectedTextColorKeyPath
                                                          source:self.definition
                                                        fallback:[UIColor darkGrayColor]];
    }
    
    return _tabBarSelectedTextColor;
}

#pragma mark - Buttons

- (UIColor *)buttonPlainBackgroundColor
{
    if (!_buttonPlainBackgroundColor) {
        _buttonPlainBackgroundColor = [[self class] colorForKeyPath:OUIButtonPlainBackgroundColorKeyPath
                                                             source:self.definition
                                                           fallback:[UIColor clearColor]];
    }
    
    return _buttonPlainBackgroundColor;
}

- (UIColor *)buttonPlainTextColor
{
    if (!_buttonPlainTextColor) {
        _buttonPlainTextColor = [[self class] colorForKeyPath:OUIButtonPlainTextColorKeyPath
                                                       source:self.definition
                                                     fallback:[UIColor darkGrayColor]];
    }
    
    return _buttonPlainTextColor;
}

- (UIColor *)buttonDestructiveBackgroundColor
{
    if (!_buttonDestructiveBackgroundColor) {
        _buttonDestructiveBackgroundColor = [[self class] colorForKeyPath:OUIButtonDestructiveBackgroundColorKeyPath
                                                                   source:self.definition
                                                                 fallback:[UIColor redColor]];
    }
    
    return _buttonDestructiveBackgroundColor;
}

- (UIColor *)buttonDestructiveTextColor
{
    if (!_buttonDestructiveTextColor) {
        _buttonDestructiveTextColor = [[self class] colorForKeyPath:OUIButtonDestructiveTextColorKeyPath
                                                             source:self.definition
                                                           fallback:[UIColor whiteColor]];
    }
    
    return _buttonDestructiveTextColor;
}

- (UIColor *)buttonActionableBackgroundColor
{
    if (!_buttonActionableBackgroundColor) {
        _buttonActionableBackgroundColor = [[self class] colorForKeyPath:OUIButtonActionableBackgroundColorKeyPath
                                                                  source:self.definition
                                                                fallback:[UIColor greenColor]];
    }
    
    return _buttonActionableBackgroundColor;
}

- (UIColor *)buttonActionableTextColor
{
    if (!_buttonActionableTextColor) {
        _buttonActionableTextColor = [[self class] colorForKeyPath:OUIButtonActionableTextColorKeyPath
                                                            source:self.definition
                                                          fallback:[UIColor whiteColor]];
    }
    
    return _buttonActionableTextColor;
}

#pragma mark - Table View

- (UIColor *)tableViewBackgroundColor
{
    if (!_tableViewBackgroundColor) {
        _tableViewBackgroundColor = [[self class] colorForKeyPath:OUITableViewBackgroundColorKeyPath
                                                           source:self.definition
                                                         fallback:[UIColor whiteColor]];
    }
    
    return _tableViewBackgroundColor;
}

- (UIColor *)tableViewSeparatorColor
{
    if (!_tableViewSeparatorColor) {
        _tableViewSeparatorColor = [[self class] colorForKeyPath:OUITableViewSeparatorColorKeyPath
                                                          source:self.definition
                                                        fallback:[UIColor lightGrayColor]];
    }
    
    return _tableViewSeparatorColor;
}

- (UIColor *)tableViewCellBackgroundColor
{
    if (!_tableViewCellBackgroundColor) {
        _tableViewCellBackgroundColor = [[self class] colorForKeyPath:OUITableViewCellBackgroundColorKeyPath
                                                               source:self.definition
                                                             fallback:[UIColor whiteColor]];
    }
    
    return _tableViewCellBackgroundColor;
}

- (UIColor *)tableViewCellSelectedBackgroundColor
{
    if (!_tableViewCellSelectedBackgroundColor) {
        _tableViewCellSelectedBackgroundColor = [[self class] colorForKeyPath:OUITableViewCellSelectedBackgroundColorKeyPath
                                                                       source:self.definition
                                                                     fallback:[UIColor lightGrayColor]];
    }
    
    return _tableViewCellSelectedBackgroundColor;
}

- (UIColor *)tableViewCellHighlightedBackgroundColor
{
    if (!_tableViewCellHighlightedBackgroundColor) {
        _tableViewCellHighlightedBackgroundColor = [[self class] colorForKeyPath:OUITableViewCellHighlightedTextColorKeyPath
                                                                          source:self.definition
                                                                        fallback:[UIColor lightGrayColor]];
    }
    
    return _tableViewCellHighlightedBackgroundColor;
}

- (UIColor *)tableViewCellTextColor
{
    if (!_tableViewCellTextColor) {
        _tableViewCellTextColor = [[self class] colorForKeyPath:OUITableViewCellTextColorKeyPath
                                                         source:self.definition
                                                       fallback:[UIColor darkGrayColor]];
    }
    
    return _tableViewCellTextColor;
}


- (UIColor *)tableViewCellSelectedTextColor
{
    if (!_tableViewCellSelectedTextColor) {
        _tableViewCellSelectedTextColor = [[self class] colorForKeyPath:OUITableViewCellSelectedTextColorKeyPath
                                                                 source:self.definition
                                                               fallback:[UIColor darkGrayColor]];
    }
    
    return _tableViewCellSelectedTextColor;
}

- (UIColor *)tableViewCellHighlightedTextColor
{
    if (!_tableViewCellHighlightedTextColor) {
        _tableViewCellHighlightedTextColor = [[self class] colorForKeyPath:OUITableViewCellHighlightedTextColorKeyPath
                                                                    source:self.definition
                                                                  fallback:[UIColor darkGrayColor]];
    }
    
    return _tableViewCellHighlightedTextColor;
}

#pragma mark - Collection View

- (UIColor *)collectionViewBackgroundColor
{
    if (!_collectionViewBackgroundColor) {
        _collectionViewBackgroundColor = [[self class] colorForKeyPath:OUICollectionViewBackgroundColorKeyPath
                                                                source:self.definition
                                                              fallback:[UIColor whiteColor]];
    }
    
    return _collectionViewBackgroundColor;
}

- (UIColor *)collectionViewCellBackgroundColor
{
    if (!_collectionViewCellBackgroundColor) {
        _collectionViewCellBackgroundColor = [[self class] colorForKeyPath:OUICollectionViewCellBackgroundColorKeyPath
                                                                    source:self.definition
                                                                  fallback:[UIColor whiteColor]];
    }
    
    return _collectionViewCellBackgroundColor;
}

- (UIColor *)collectionViewCellSelectedBackgroundColor
{
    if (!_collectionViewCellSelectedBackgroundColor) {
        _collectionViewCellSelectedBackgroundColor = [[self class] colorForKeyPath:OUICollectionViewCellSelectedBackgroundColorKeyPath
                                                                            source:self.definition
                                                                          fallback:[UIColor lightGrayColor]];
    }
    
    return _collectionViewCellSelectedBackgroundColor;
}

- (UIColor *)collectionViewCellHighlightedBackgroundColor
{
    if (!_collectionViewCellHighlightedBackgroundColor) {
        _collectionViewCellHighlightedBackgroundColor = [[self class] colorForKeyPath:OUICollectionViewCellHighlightedBackgroundColorKeyPath
                                                                               source:self.definition
                                                                             fallback:[UIColor lightGrayColor]];
    }
    
    return _collectionViewCellHighlightedBackgroundColor;
}

- (UIColor *)collectionViewCellTextColor
{
    if (!_collectionViewCellTextColor) {
        _collectionViewCellTextColor = [[self class] colorForKeyPath:OUICollectionViewCellTextColorKeyPath
                                                              source:self.definition
                                                            fallback:[UIColor darkGrayColor]];
    }
    
    return _collectionViewCellTextColor;
}

- (UIColor *)collectionViewCellSelectedTextColor
{
    if (!_collectionViewCellSelectedTextColor) {
        _collectionViewCellSelectedTextColor = [[self class] colorForKeyPath:OUICollectionViewCellSelectedTextColorKeyPath
                                                                      source:self.definition
                                                                    fallback:[UIColor darkGrayColor]];
    }
    
    return _collectionViewCellSelectedTextColor;
}

- (UIColor *)collectionViewCellHighlightedTextColor
{
    if (!_collectionViewCellHighlightedTextColor) {
        _collectionViewCellHighlightedTextColor = [[self class] colorForKeyPath:OUICollectionViewCellHighlightedTextColorKeyPath
                                                                         source:self.definition
                                                                       fallback:[UIColor darkGrayColor]];
    }
    
    return _collectionViewCellHighlightedTextColor;
}

#pragma mark - View

- (UIColor *)viewBackgroundColor
{
    if (!_viewBackgroundColor) {
        _viewBackgroundColor = [[self class] colorForKeyPath:OUIViewBackgroundColorKeyPath
                                                      source:self.definition
                                                    fallback:[UIColor whiteColor]];
    }
    
    return _viewBackgroundColor;
}

@end
