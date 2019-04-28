//
//  LXHomeItemView.m
//  LXScrollViewItemDemo
//
//  Created by heyong on 2019/4/28.
//  Copyright © 2019年 liuxing. All rights reserved.
//

#import "LXHomeItemView.h"

@interface LXHomeItemView  ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UIPageControl * pageControl;

@end

static NSString *const HomeItemCellID = @"HomeItemCellID";

@implementation LXHomeItemView

+ (instancetype)itemViewWithFrame:(CGRect)frame delegate:(id<LXHomeItemViewDelegate>)delegate titles:(NSArray *)titles {
    LXHomeItemView *itemView = [[self alloc] initWithFrame:frame];
    itemView.titles = titles;
    itemView.delegate = delegate;
    return itemView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-30) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[LXHomeItemCell class] forCellWithReuseIdentifier:HomeItemCellID];
    [self addSubview:_collectionView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_collectionView.bounds.size.width/2-100/2, CGRectGetMaxY(_collectionView.frame), 100, 20)];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self addSubview:_pageControl];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    _pageControl.numberOfPages = self.titles.count;
}

#pragma mark - delegate & dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXHomeItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeItemCellID forIndexPath:indexPath];
    cell.titles = self.titles;
    cell.index = indexPath.item;
    cell.delegate = self.delegate;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    self.pageControl.currentPage = page;
}


@end



@interface LXHomeItemCell ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic,strong)UICollectionView * collectionView;

@end

static NSString *const HomeSubItemCellID = @"HomeSubItemCellID";
@implementation LXHomeItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 20;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((self.bounds.size.width-6*20)/5, 75);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[LXHomeFiveItemCell class] forCellWithReuseIdentifier:HomeSubItemCellID];
    [self addSubview:_collectionView];
}

#pragma mark - delegate & dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.titles[_index] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXHomeFiveItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeSubItemCellID forIndexPath:indexPath];
    NSDictionary * dic = self.titles[_index][indexPath.item];
    [cell setupImageName:dic[@"image"] titles:dic[@"title"]];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeItemView:didSelectItemAtSection:Index:)]) {
        [self.delegate homeItemView:((LXHomeItemView *)self.superview.superview) didSelectItemAtSection:_index Index:indexPath.item];
    }
}
@end

@interface LXHomeFiveItemCell ()

@property (nonatomic,strong)UIImageView *itemImageV;
@property (nonatomic,strong)UILabel *titleLab;

@end
@implementation LXHomeFiveItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 46, 46)];
        [self.contentView addSubview:_itemImageV];

        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_itemImageV.frame), self.bounds.size.width, 20)];
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        _titleLab.text = @"家常菜品";
    }
    return self;
}

- (void)setupImageName:(NSString *)imageName titles:(NSString *)title {
    self.itemImageV.image = [UIImage imageNamed:imageName];
    self.titleLab.text = title;
}
@end
