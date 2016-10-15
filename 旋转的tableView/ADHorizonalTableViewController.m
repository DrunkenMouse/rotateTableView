//
//  ADHorizonalTableViewController.m
//  旋转的tableView
//
//  Created by 王奥东 on 16/9/19.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADHorizonalTableViewController.h"



@interface ADHorizonalTableViewController ()

@end

@implementation ADHorizonalTableViewController

-(instancetype)initWithViewControllers:(NSArray *)controllers{
    self = [super init];
    if (self) {
        _controllers = [[NSMutableArray alloc] initWithArray:controllers];
        for (UIViewController *controller in controllers) {
            [self addChildViewController:controller];
        }
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [UITableView new];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollsToTop = NO;
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.bounces = NO;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _controllers.count + 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"defaultVCCell%ld",(long)indexPath.row]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"defaultVCCell%ld",(long)indexPath.row]];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIViewController *controller = _controllers[indexPath.row];
        controller.view.frame = cell.contentView.bounds;
        [cell.contentView addSubview:controller.view];
        
    }
    if (indexPath.row == 0) {
        NSLog(@"purple = %ld",(long)indexPath.row);
        cell.backgroundColor = [UIColor purpleColor];
    }else {
        NSLog(@"blue = %ld",(long)indexPath.row);
        cell.contentView.backgroundColor = [UIColor blueColor];
    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return tableView.frame.size.width;
}


#pragma mark - <UIScrollViewDelegate>

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollStop:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self scrollStop:NO];
    if (_viewDidScroll) {
        _viewDidScroll();
    }
    
}


-(void)scrollToViewAtIndex:(NSUInteger)index {
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    _currentIndex = index;
    
    if (_viewDidAppear) {
        _viewDidAppear(index);
    }
    
}




-(void)scrollStop:(BOOL)didScrollStop{
    
    CGFloat horizonalOffset = self.tableView.contentOffset.y;
    
    //垂直高度
    CGFloat screenWidth = self.tableView.frame.size.width;
    
    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
    
    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;
    
    if (horizonalOffset != focusIndex * screenWidth) {
        
        NSUInteger animationIndex = horizonalOffset > focusIndex * screenWidth ? focusIndex + 1: focusIndex - 1;
        if (focusIndex > animationIndex) {
            offsetRatio = 1 - offsetRatio;
        }
        if (_scrollView) {
            _scrollView(offsetRatio,focusIndex,animationIndex);
        }
    }
    if (didScrollStop) {
        _currentIndex = focusIndex;
        if (_changeIndex) {
            _changeIndex(focusIndex);
        }
    }
    
}








@end
