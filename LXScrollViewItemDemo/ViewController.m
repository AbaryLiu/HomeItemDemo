//
//  ViewController.m
//  LXScrollViewItemDemo
//
//  Created by heyong on 2019/4/28.
//  Copyright © 2019年 liuxing. All rights reserved.
//

#import "ViewController.h"
#import "LXHomeItemView.h"

@interface ViewController ()<LXHomeItemViewDelegate>

@property (nonatomic,strong)NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LXHomeItemView *itemView = [LXHomeItemView itemViewWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 190) delegate:self titles:self.titles];
    [self.view addSubview:itemView];
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@[@{@"image":@"home_item1",@"title":@"美味食品"},
                    @{@"image":@"home_item2",@"title":@"在线超市"},
                    @{@"image":@"home_item3",@"title":@"生鲜蔬果"},
                    @{@"image":@"home_item4",@"title":@"外卖"},
                    @{@"image":@"home_item5",@"title":@"汉堡披萨"},
                    @{@"image":@"home_item6",@"title":@"家常菜品"},
                    @{@"image":@"home_item7",@"title":@"到店自提"},
                    @{@"image":@"home_item8",@"title":@"下午茶"},
                    @{@"image":@"home_item9",@"title":@"火锅"},
                    @{@"image":@"home_item10",@"title":@"鲜花蛋糕"}],
                    @[@{@"image":@"home_item1",@"title":@"外卖"},
                    @{@"image":@"home_item2",@"title":@"其他"}]];
    }
    return _titles;
}

#pragma mark - LXHomeItemViewDelegate

- (void)homeItemView:(LXHomeItemView *)itemView didSelectItemAtSection:(NSInteger)section Index:(NSInteger)index {
    NSLog(@"第%zd组  第%zd个",section,index);
}
@end
