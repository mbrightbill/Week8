//
//  ViewController.m
//  Week8
//
//  Created by Matthew Brightbill on 11/24/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIViewController *blueVC;
@property (retain, nonatomic) IBOutlet UIButton *burgerButton;
@property (assign, nonatomic) BOOL burgerMenuIsOpen;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *footballTeams;
@property (strong, nonatomic) UIViewController *goSeahawksVC;
@property (assign, nonatomic) BOOL goSeahawksIsOpen;
@property (assign, nonatomic) BOOL blueIsOpen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"BLUE_VC"] autorelease];
    //self.goSeahawksVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"GOSEAHAWKS_VC"] autorelease];
    
    [self addChildViewController:self.blueVC];
    self.blueVC.view.frame = self.view.frame;
    [self.view insertSubview:self.blueVC.view belowSubview:self.burgerButton];
    [self.view insertSubview:self.tableView.viewForBaselineLayout belowSubview:self.blueVC.view];
    [self.blueVC didMoveToParentViewController:self];
    
    self.burgerMenuIsOpen = NO;
    self.goSeahawksIsOpen = NO;
    self.blueIsOpen = YES;
    
    self.footballTeams = [[NSArray alloc] initWithObjects:@"Seattle Seahawks", @"Philadelphia Eagles", @"Denver Broncos", nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (IBAction)didPressBurger:(id)sender {
    NSLog(@"Burger mmmm");
    
    [UIView animateWithDuration:0.4 animations:^{
        if (self.burgerMenuIsOpen == NO) {
            if (self.goSeahawksIsOpen == YES) {
                self.burgerMenuIsOpen = YES;
                self.goSeahawksVC.view.frame = CGRectMake(self.view.frame.size.width * 0.6, 0, self.view.frame.size.width, self.view.frame.size.height);
                
            } else {
                self.blueVC.view.frame = CGRectMake(self.view.frame.size.width * 0.6, 0, self.view.frame.size.width, self.view.frame.size.height);
                self.burgerMenuIsOpen = YES;
                self.blueVC.view.layer.borderWidth = 1.0f;
                self.blueVC.view.layer.borderColor = [UIColor blueColor].CGColor;
            }
        } else {
            if (self.goSeahawksIsOpen == YES) {
                self.burgerMenuIsOpen = NO;
                self.goSeahawksVC.view.frame = CGRectMake(self.view.frame.size.width * 0, 0, self.view.frame.size.width, self.view.frame.size.height);
            } else {
                self.blueVC.view.frame = CGRectMake(self.view.frame.size.width * 0, 0, self.view.frame.size.width, self.view.frame.size.height);
                self.burgerMenuIsOpen = NO;
                self.blueVC.view.layer.borderWidth = 0;
                self.blueVC.view.layer.borderColor = nil;
            }
        }
        
    } completion:^(BOOL finished) {
        NSLog(@"Moved because of burger click");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.footballTeams.count != 0) {
        return self.footballTeams.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = self.footballTeams[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.blueIsOpen == YES) {
        [self.blueVC removeFromParentViewController];
        self.blueIsOpen = NO;
        self.goSeahawksVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"GOSEAHAWKS_VC"] autorelease];
        [self addChildViewController:self.goSeahawksVC];
        [self.view insertSubview:self.goSeahawksVC.view belowSubview:self.burgerButton];
        [self.view insertSubview:self.tableView.viewForBaselineLayout belowSubview:self.goSeahawksVC.view];
        [self.goSeahawksVC didMoveToParentViewController:self];
        self.burgerMenuIsOpen = NO;
        self.goSeahawksIsOpen = YES;
    }

    self.goSeahawksVC.view.frame = CGRectMake(self.view.frame.size.width * 0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.burgerMenuIsOpen = NO;
    self.goSeahawksIsOpen = YES;
    
    
    
}

- (void)dealloc {
    [_burgerButton release];
    [_tableView release];
    [super dealloc];
}
@end
