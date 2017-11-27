//
//  CustomSearchBar.m
//  
//
//  Created by Teng Kiefer on 12-5-20.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "CustomSearchBar.h"
#import "UIView+Size.h"
#import "UIColor+Hex.h"

@implementation CustomSearchBar

@synthesize placeholder = _placeholder;
@synthesize text = _text;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        backView = [[UIImageView alloc] init];
        backView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
        backView.layer.cornerRadius = 3.0;
        backView.layer.masksToBounds = true;
        [self addSubview:backView];
        
        iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"search2"];
        [self addSubview:iconView];
        
        inputField = [[UITextField alloc] init];
        inputField.backgroundColor = [UIColor clearColor];
        inputField.font = [UIFont systemFontOfSize:12.0];
        inputField.textColor = [UIColor blackColor];
        inputField.returnKeyType = UIReturnKeySearch;
        inputField.keyboardType = UIKeyboardTypeDefault;
        inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        inputField.tintColor = [UIColor blackColor];
        [self addSubview:inputField];
    }
    return self;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        inputField.delegate = delegate;
    }
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        inputField.text = text;
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor colorWithHex:0x888888]};
        inputField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attrs];
    }
}

- (void)resignFirstResponder {
    [inputField resignFirstResponder];
}
-(void)becomeFirstResponder
{
    [inputField becomeFirstResponder];
}
- (NSAttributedString *)attributedPlaceholder:(NSString *)placeholder {
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor colorWithHex:0x888888]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:placeholder attributes:attrs];
    return attributedString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    backView.frame = CGRectMake(0, 0, self.width, self.height);
    iconView.size = iconView.image.size;
    iconView.centerX = 18.0;
    iconView.centerY = self.height/2;
    inputField.frame = CGRectMake(35, 0, backView.width - 35, self.height);
}

@end
