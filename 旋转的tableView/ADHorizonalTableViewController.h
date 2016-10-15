//
//  ADHorizonalTableViewController.h
//  旋转的tableView
//
//  Created by 王奥东 on 16/9/19.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADHorizonalTableViewController : UITableViewController

/*!  @brief 当前页  */
@property (nonatomic, assign) NSInteger currentIndex;
/*!  @brief 子VC  */
@property(nonatomic, strong) NSMutableArray *controllers;
///*!  @brief 改变index  */
@property(nonatomic, copy) void (^changeIndex)(NSUInteger index);
///*!  @brief 描述  */
@property(nonatomic, copy) void (^scrollView)(CGFloat offsetRatio,NSUInteger focusIndex, NSUInteger animationIndex);

@property(nonatomic, copy) void (^viewDidAppear)(NSInteger index);

@property(nonatomic, copy) void (^viewDidScroll)();

-(instancetype)initWithViewControllers:(NSArray *)controllers;

-(void)scrollToViewAtIndex:(NSUInteger)index;

@end
