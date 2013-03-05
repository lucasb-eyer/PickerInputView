//
//  ViewController.m
//  PickerInputViewExample
//
//  Created by Lucas Beyer on 5/03/13.
//  Copyright (c) 2013 Lucas Beyer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    PickerInputView* _ivLocation;
    PickerInputView* _ivDish;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // The different choices the user can pick from.
    // In a real app, this data probably comes from some backend.
    NSArray *locations = [[NSArray alloc] initWithObjects:@"At home", @"At university", @"In the hackerspace", @"At work", @"In the spaceship", nil];
    
    // Creates the picker input view using the above data and sets
    // the callback to be this object's "locationSelected" method.
    // It will get the item the user selected as an argument.
    self->_ivLocation = [[PickerInputView alloc] initWithData:locations
                                                 andDoneTarget:self
                                                 andAction:@selector(locationSelected:)];

    // This associates the picker input view with the actual text field
    // of which it should replace the default virtual keyboard input method.
    self->_ivLocation.parent = (UITextField*)[self.view viewWithTag:100];


    // Aaaand the same story for dishes, but here we allow the user to cancel.
    NSArray *dishes = [[NSArray alloc] initWithObjects:@"Spaghetti", @"Pizza", @"Tom Kha Gai", @"Salad", nil];
    self->_ivDish = [[PickerInputView alloc] initWithData:dishes
                                             andDoneTarget:self
                                             andAction:@selector(dishSelected:)
                                             andCancel:@selector(dishCancelled)];
    self->_ivDish.parent = (UITextField*)[self.view viewWithTag:200];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationSelected:(NSString*) location
{
    // Using this information, go ahead on your quest of world domination!
    NSLog(@"The user prefers to eat %@", location);
}

- (void)dishSelected:(NSString*) dish
{
    NSLog(@"The user chose to eat a %@", dish);
}

- (void)dishCancelled
{
    NSLog(@"The user cancelled the dish selection.");
}

@end
