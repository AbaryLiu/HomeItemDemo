//
//  LXHomeItemView.h
//  LXScrollViewItemDemo
//
//  Created by heyong on 2019/4/28.
//  Copyright © 2019年 liuxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXHomeItemView,LXHomeItemCell,LXHomeFiveItemCell;

@protocol LXHomeItemViewDelegate <NSObject>

@optional
- (void)homeItemView:(LXHomeItemView *)itemView didSelectItemAtSection:(NSInteger)section Index:(NSInteger)index;
@end

@interface LXHomeItemView : UIView

@property (nonatomic, weak) id<LXHomeItemViewDelegate> delegate;
@property (nonatomic,strong)NSArray *titles;

+ (instancetype)itemViewWithFrame:(CGRect)frame delegate:(id<LXHomeItemViewDelegate>)delegate titles:(NSArray *)titles;
@end


@interface LXHomeItemCell : UICollectionViewCell

@property (nonatomic, weak) id<LXHomeItemViewDelegate> delegate;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,assign)NSInteger index;

@end

@interface LXHomeFiveItemCell : UICollectionViewCell

- (void)setupImageName:(NSString *)imageName titles:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
