//
//  BMAdScrollView.h
//  UIPageController
//
//  Created by skyming on 14-5-31.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMButton : UIButton

@end
/**
 *  @Class  BMImageView
 */
// 按钮点击协议
@protocol UrLImageButtonDelegate <NSObject>
- (void)click:(int)vid;
@end

@interface BMImageView : UIView
//按钮点击委托对象
@property(nonatomic,strong)id<UrLImageButtonDelegate> uBdelegate;

/**
 *  @method initWithImageName: title: x: tFrame: iHeight: titleHidden:
 *
 *  @param imageName    图片url字符串
 *  @param titleStr           标题
 *  @param xPoint            图片横坐标
 *  @param titleFrame      自定义标题Frame
 *  @param imageHeight   视图高度
 *  @param isTitleHidden  标题是否隐藏
 *
 *  @discussion  当标题隐藏时注意pageControl 位置的调整(titleFrame)
 */
-(instancetype)initWithImageName:(NSString *)imageName x:(CGFloat)xPoint tFrame:(CGRect)titleFrame iHeight:(CGFloat)imageHeight titleHidden:(BOOL) isTitleHidden;
@end



/**
 *  @Class  BMAdScrollView
 */

//点击scrollView中的图片点击事件协议
@protocol ValueClickDelegate <NSObject>
-(void)buttonClick:(int)vid;
@end

@interface BMAdScrollView : UIView

@property (nonatomic) CGPoint pageCenter; // pageControl 中心点
@property (nonatomic) CGRect titleFrame;
@property (nonatomic,strong) UIColor *titleBackColor;
@property (nonatomic,strong) NSTimer *timer; // Don't forget set valid when not in front 
@property (nonatomic,strong)id<ValueClickDelegate> vDelegate;
/**
 *  @method initWithNameArr: titleArr: height:
 *
 *  @param imageArr       图片数组
 *  @param titleArr          标题数组
 *  @param heightValue   视图高度
 *  @param offsetY           高度偏移量
 *
 *  @discussion     默认首页为零，当视图出现或消失时，注意对timer的处理
 */
- (instancetype)initWithNameArr:(NSMutableArray *)imageArr height:(float)heightValue offsetY:(CGFloat )offsetY;

@end
