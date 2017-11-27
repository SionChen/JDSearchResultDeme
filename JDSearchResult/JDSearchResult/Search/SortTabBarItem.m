//
//  SortTabBarItem.m
//  superwan
//
//  Created by kiefer on 15/10/11.
//  Copyright (c) 2015年 super. All rights reserved.
//

#import "SortTabBarItem.h"
#import "UIView+Size.h"

@implementation SortTabBarItem

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setSortType:(SortType)sortType {
    if (_sortType != sortType) {
        _sortType = sortType;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.sortType == SortTypePriceAscending) {
        _imageView.image = [UIImage imageNamed:@"arrowUp"];
    } else if (self.sortType == SortTypePriceDescending) {
        _imageView.image = [UIImage imageNamed:@"arrowDown"];
    } else {
        _imageView.image = [UIImage imageNamed:@"arrowUpDown"];
    }
    _imageView.hidden = !self.isSortTypePrice;
    _imageView.size = _imageView.image.size;
    CGSize textSize = [self.title sizeWithAttributes:@{NSFontAttributeName:self.font}];
    _imageView.right = self.width/2 + textSize.width/2 + 10;
    _imageView.centerY = self.height/2;
}

@end
