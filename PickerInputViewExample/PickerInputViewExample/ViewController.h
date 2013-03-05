//
//  ViewController.h
//  PickerInputViewExample
//
//  Created by Lucas Beyer on 5/03/13.
//  Copyright (c) 2013 Lucas Beyer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PickerInputView.h"

@interface ViewController : UIViewController

- (void)locationSelected:(NSString*) location;
- (void)dishSelected:(NSString*) dish;
- (void)dishCancelled;

@end
