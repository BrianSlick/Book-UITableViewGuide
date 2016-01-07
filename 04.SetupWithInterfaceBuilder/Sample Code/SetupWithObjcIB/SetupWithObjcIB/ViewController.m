//
//  ViewController.m
//  SetupWithObjcIB
//
//  Created by Brian Slick on 1/7/16.
//  Copyright © 2016 Brian Slick. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showButtonPressed:(id)sender
{
    CustomViewController *customViewController = [[CustomViewController alloc] init];
    
    [self presentViewController:customViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
