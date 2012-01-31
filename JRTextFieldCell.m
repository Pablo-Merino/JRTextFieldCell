//
//  JRTextFieldCell.m
//  Stuff
//
//  Created by John Heaton on 1/31/12.
//  Copyright (c) 2012 GJB Software. All rights reserved.
//

#import "JRTextFieldCell.h"

@interface JRTextFieldCell ()

- (void)_applyTextFieldOffset;

@end

@implementation JRTextFieldCell

@synthesize textField=_textField;
@synthesize textFieldOffset=_offset;
@synthesize autoSizesWithLabel=_autoSize;
@synthesize returnDelegate=_returnDelegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.delegate = self; 
        
        self.textFieldOffset = 0;
        self.autoSizesWithLabel = NO;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)_applyTextFieldOffset {    
    CGRect frame;
    frame.origin.x = (10 + self.textFieldOffset);
    frame.origin.y = ((self.contentView.frame.size.height / 2) - (self.textField.frame.size.height / 2));
    frame.size.width = ((self.contentView.frame.size.width - 20) - self.textFieldOffset);
    frame.size.height = self.textField.frame.size.height;
    if(self.autoSizesWithLabel) {
        NSInteger offset = ([self.textLabel.text sizeWithFont:self.textLabel.font].width + 5);
        
        frame.origin.x += offset;
        frame.size.width -= offset;
    }
    
    [self.textField setFrame:frame];
}

- (void)beginEditing {
    [self.textField becomeFirstResponder];
}

- (void)endEditing {
    [self.textField resignFirstResponder];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textField sizeToFit];
    [self _applyTextFieldOffset];
    
    [self.contentView bringSubviewToFront:self.textField];
}

- (void)prepareForReuse {
    self.returnDelegate = nil;
    self.textFieldOffset = 0;
    self.autoSizesWithLabel = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(self.returnDelegate && [self.returnDelegate respondsToSelector:@selector(textFieldCellReturned:)])
        [self.returnDelegate textFieldCellReturned:self];
    
    return YES;
}

- (void)dealloc {
    [self.textField release];
    [super dealloc];
}

@end
