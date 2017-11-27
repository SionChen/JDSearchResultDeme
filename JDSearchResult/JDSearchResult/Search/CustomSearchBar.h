//
//  CustomSearchBar.h
//  
//
//  Created by Teng Kiefer on 12-5-20.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSearchBar : UIView {
    UIImageView *backView;
    UIImageView *iconView;
    UITextField *inputField;
}

@property(nonatomic, weak) id<UITextFieldDelegate> delegate;
@property(nonatomic, copy) NSString *placeholder;
@property(nonatomic, copy) NSString *text;

- (void)resignFirstResponder;
- (void)becomeFirstResponder;

@end
