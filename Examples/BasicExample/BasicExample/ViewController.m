//
//  ViewController.m
//  BasicExample
//
//  Created by Nahuel Marisi on 2015-07-21.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import "ViewController.h"
#import "TBRJSONMapper.h"
#import "Address.h"
#import "Phone.h"

static NSString *const kCellIdentifier = @"basicCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate >

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *partTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Address *currentAddress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load all recipes JSON files
    TBRJSONMapper *mapper = [[TBRJSONMapper alloc] init];
    
    NSString *pathToJSONAddress = @"address";
    
    self.currentAddress = [mapper objectGraphForJSONResource:pathToJSONAddress
                                           withRootClassName:@"Address"];
    
    NSAssert(self.currentAddress != nil, @"Address is nil");
    
    self.nameLabel.text = self.currentAddress.name;
    self.companyLabel.text = self.currentAddress.company;
    self.usernameLabel.text = self.currentAddress.username;
    self.emailLabel.text = self.currentAddress.email;
    self.jobTitleLabel.text = self.currentAddress.jobTitle;
    self.partTimeLabel.text = ([self.currentAddress.partTime boolValue]) ? @"Yes" : @"No";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentAddress.phones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
   
    Phone *currentPhone =  self.currentAddress.phones[indexPath.row];
    NSString *phoneString = [NSString stringWithFormat:@"%@: %@",
                             currentPhone.type, currentPhone.number];
    cell.textLabel.text = phoneString;
    
    
    return cell;
}



@end
