//
//  LGIntroductionViewController.h
//  ladygo
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 ju.taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();
typedef void (^DidSkipedEnter)();

@interface ZWIntroductionViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UIButton *skipBtn;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;
@property (nonatomic, copy) DidSkipedEnter didSkipedEnter;

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

- (id)initWithCoverImgNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames enterBtn:(UIButton*)button kipButton:(UIButton *)skipBtn;

@end
