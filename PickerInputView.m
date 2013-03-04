// Copyright (C) 2013 Lucas Beyer (http://lucasb.eyer.be)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

#import "PickerInputView.h"

@interface PickerInputView () {
    id _target;
    SEL _onDone;
    SEL _onCancel;
    UIPickerView *_picker;
    UIToolbar *_toolbar;
    UIBarButtonItem *_doneButton;
    UIBarButtonItem *_cancelButton;
}

@end

@implementation PickerInputView

@synthesize data;
@synthesize parent;

- (id)initWithData:(NSArray *)data andDoneTarget:(id)obj andAction:(SEL)onDone
{
    if (self = [super init]) {
        self.data = data;
        self->_target = obj;
        self->_onDone = onDone;
        self->_onCancel = nil;

        self->_picker = [[UIPickerView alloc] init];
        self->_picker.delegate = self;
        self->_picker.dataSource = self;
        self->_picker.showsSelectionIndicator = YES;

        self->_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        self->_doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                            target:self action:@selector(onDone)];
        self->_cancelButton = nil;
        [self->_toolbar setItems:[NSArray arrayWithObject:_doneButton]];
    }

    return self;
}

- (id)initWithData:(NSArray *)datafill andDoneTarget:(id)obj andAction:(SEL)onDone andCancel:(SEL)onCancel
{
    self = [self initWithData:datafill andDoneTarget:obj andAction:onDone];

    if (self) {
        self->_onCancel = onCancel;

        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self->_cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                      target:self
                                                                                      action:@selector(onCancel)];
        [self->_toolbar setItems:[NSArray arrayWithObjects:self->_doneButton, flexibleSpace, self->_cancelButton, nil]];
    }

    return self;
}

- (void)setParent:(UITextField *)newparent
{
    parent = newparent;

    parent.inputView = self->_picker;
    parent.inputAccessoryView = self->_toolbar;
}


- (void)onDone {
    NSInteger row = [self->_picker selectedRowInComponent:0];

    // The selector is not returning anything allocated, so it's OK.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self->_target performSelector:self->_onDone withObject:[self.data objectAtIndex:row]];
#pragma clang diagnostic pop

    [parent resignFirstResponder];
}

- (void)onCancel {
    // The selector is not returning anything allocated, so it's OK.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self->_target performSelector:self->_onCancel];
#pragma clang diagnostic pop

    [parent resignFirstResponder];
}

#pragma mark - picker view delegate/datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.data count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.data objectAtIndex:row];
}


@end
