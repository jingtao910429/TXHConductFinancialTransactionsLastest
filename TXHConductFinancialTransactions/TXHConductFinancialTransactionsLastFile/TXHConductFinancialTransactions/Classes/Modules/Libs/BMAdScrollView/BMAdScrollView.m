//
//  BMAdScrollView.m
//  UIPageController
//
//  Created by skyming on 14-5-31.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMAdScrollView.h"
//#import "UrlImageButton.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define PAGE_HEIGHT 37
#define rightDirection 1
#define zeroDirection 0
#define INTERVALE 4

@implementation BMButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end


@implementation BMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
    }
    return self;
}

//新定义初始化视图方法
-(id)initWithImageName:(NSString *)imageName x:(CGFloat)xPoint tFrame:(CGRect)titleFrame iHeight:(CGFloat)imageHeight titleHidden:(BOOL)isTitleHidden
{
    //调用原始初始化方法
    CGFloat imageH = imageHeight;
    if (!isTitleHidden) {
        imageH = imageHeight - 30;
    }
    self = [super initWithFrame:CGRectMake(xPoint, 0, kScreenWidth, imageH)];
    if (self) {
        // Initialization code
        //设置图片视图
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, kScreenWidth, imageH);
        [button sd_setImageWithURL:[NSURL URLWithString:imageName] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [button setAdjustsImageWhenHighlighted:NO];
        
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, imageH)];
//        //给定网络图片路径
//        
////        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]
////                     placeholderImage:[UIImage imageNamed:@"shakeText"]];
//        
////        [imageView setImage:[UIImage imageNamed:@"shakeText"] forState:UIControlStateNormal];
//        //设置点击方法
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
//        [tap addTarget:self action:@selector(click)];
////        [imageView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        [imageView addGestureRecognizer:tap];
        [self addSubview:button];
        
        if (isTitleHidden) {
            return self;
        }
    }
    return self;
}

-(void)click{
    [self.uBdelegate click:self.tag];
}

@end

@interface BMAdScrollView()<UIScrollViewDelegate,UrLImageButtonDelegate>
{
    int switchDirection;//方向
//    CGFloat offsetY;
    NSMutableArray *imageNameArr;//图片数组
    
    UIScrollView *imageSV;//滚动视图
    UIPageControl *pageControl;
}
@end
static  int pageNumber;//页码

@implementation BMAdScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
//自定义实例化方法

- (instancetype)initWithNameArr:(NSMutableArray *)imageArr height:(float)heightValue offsetY:(CGFloat)offsetY {
    
    self = [super initWithFrame:CGRectMake(0, offsetY, kScreenWidth, heightValue)];
    
    if (self) {
        
        pageNumber=0;//设置当前页为1
        imageNameArr = imageArr;

        [self addADScrollView:imageArr.count height:heightValue];
        [self addImages:imageArr];
        if (imageArr && imageArr.count != 1) {
            [self addPageControl:imageArr.count];
            imageSV.scrollEnabled = YES;
        }else{
            imageSV.scrollEnabled = NO;
        }
        
        
      //设置NSTimer
        _timer = [NSTimer scheduledTimerWithTimeInterval:INTERVALE target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        
    }
    return self;
}
- (void)addADScrollView:(NSInteger)count height:(CGFloat)heightValue
{
    //初始化scrollView
    imageSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, heightValue)];
    //设置sview属性
    
    imageSV.directionalLockEnabled = YES;//锁定滑动的方向
    imageSV.pagingEnabled = YES;//滑到subview的边界
    imageSV.bounces = NO;
    imageSV.delegate = self;
    imageSV.showsVerticalScrollIndicator = NO;//不显示垂直滚动条
    imageSV.showsHorizontalScrollIndicator = NO;//不显示水平滚动条
    
    CGSize newSize = CGSizeMake(WIDTH * (count + 2),  imageSV.bounds.size.height);//设置scrollview的大小
    [imageSV setContentSize:newSize];
    [self addSubview:imageSV];

}
- (void)addImages:(NSArray *)imageArr
{
    
    if (imageArr.count == 0) {
        return;
    }
    
    for (int i = 0; i <= imageArr.count +1; i++) {
        
        NSString *imageURL = @"";
        if (i != imageArr.count +1 && i != 0) {
            imageURL = imageArr[i - 1];
        }
        if (i == 0) {
            
            imageURL = imageArr[imageArr.count - 1];
            
        }else if(i == imageArr.count +1)
        {
            imageURL = imageArr[0];
        }
        //创建内容对象
        CGRect titleRect = CGRectMake(0, 150, 320, 30);
        BMImageView *imageView =  [[BMImageView alloc]initWithImageName:imageURL x:WIDTH*i tFrame:titleRect iHeight:imageSV.frame.size.height titleHidden:YES];
        
        //制定AOView委托
        imageView.uBdelegate = self;
        //设置视图标示
        imageView.tag = i;
        //添加视图
        [imageSV addSubview:imageView];
    }
    [imageSV setContentOffset:CGPointMake(0, 0)];
    [imageSV scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,self.frame.size.height) animated:YES]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页

}
- (void)addPageControl:(NSInteger)count
{
    CGRect rect =  CGRectMake(0, 180, WIDTH, PAGE_HEIGHT);
    pageControl = [[UIPageControl alloc]initWithFrame:rect];
    
    if (_pageCenter.y == 0.0) {
        _pageCenter.y = self.frame.size.height - 15;
        _pageCenter.x = pageControl.center.x;
    }
    pageControl.center = _pageCenter;
    pageControl.numberOfPages = count;
//    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:pageControl];
    
}

- (void)setPageCenter:(CGPoint)pageCenter
{
    pageControl.center = pageCenter;
}

// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = imageSV.frame.size.width;
    int page = floor((imageSV.contentOffset.x - pagewidth/([imageNameArr count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = imageSV.frame.size.width;
    int currentPage = floor((imageSV.contentOffset.x - pagewidth/ ([imageNameArr count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [imageSV scrollRectToVisible:CGRectMake(WIDTH * [imageNameArr count],0,WIDTH,HEIGHT) animated:YES]; // 序号0 最后1页
    }
    else if (currentPage==([imageNameArr count]+1))
    {
        [imageSV scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:YES]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = pageControl.currentPage; // 获取当前的page
    [imageSV scrollRectToVisible:CGRectMake(WIDTH*(page+1),0,WIDTH,HEIGHT) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page > imageNameArr.count-1 ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}

#pragma UBdelegate
-(void)click:(int)vid{
    //调用委托实现方法
    [self.vDelegate buttonClick:vid];
}


-(void)dealloc
{
    [_timer invalidate];
}
@end
