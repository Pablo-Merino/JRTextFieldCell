//
//  JRTextFieldCell.h
//  Stuff
//
//  Created by John Heaton on 1/31/12.
//  Copyright (c) 2012 GJB Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JRTextFieldCellDelegate;

@interface JRTextFieldCell : UITableViewCell <UITextFieldDelegate> {
    UITextField                 *_textField;
    NSUInteger                  _offset;
    BOOL                        _autoSize;
    id<TextFieldCellDelegate>   _returnDelegate;
}

// The text field. Customize as you wish.
@property (nonatomic, readonly) UITextField *textField;

// The amount to offset the y position of the textField's frame
@property (nonatomic, assign) NSUInteger textFieldOffset;

// This will automatically align the text field to the right of the textLabel.
// NOTE: This CAN be used with the textFieldOffset property. It will be added.
@property (nonatomic, assign) BOOL autoSizesWithLabel;

// Delegate gets a message when you hit return on the text field.
// Convenient for return chains in tables where there are multiple text cells
@property (nonatomic, assign) id<JRTextFieldCellDelegate> returnDelegate;

// Just convenience methods for becoming/resigning first responder
- (void)beginEditing;
- (void)endEditing;

@end


@protocol JRTextFieldCellDelegate <NSObject>

- (void)textFieldCellReturned:(JRTextFieldCell *)textFieldCell;

@end