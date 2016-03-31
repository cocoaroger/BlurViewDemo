//
//  ViewController.m
//  BlurViewDemo
//
//  Created by roger wu on 16/3/31.
//  Copyright © 2016年 roger.wu. All rights reserved.
//

#import "ViewController.h"
#import "RGLiveBlurView.h"

@interface ViewController ()

@property (nonatomic, weak) RGLiveBlurView *blurView;

@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBlurView];
}

- (void)setupBlurView {
    RGLiveBlurView *blurView = [[RGLiveBlurView alloc] init];
    blurView.originalImage = [UIImage imageNamed:@"blur_bg"];
    blurView.scrollView = self.tableView;
    self.tableView.backgroundView = blurView;
    [self.view addSubview:blurView];
    self.blurView = blurView;
    [self.view sendSubviewToBack:blurView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(300.f, 0, 0, 0);
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *temp = [NSMutableArray array];
        NSArray *countryCodes = [NSLocale ISOCountryCodes];
        for (NSString *countryCode in countryCodes) {
            NSString *identifier = [NSLocale localeIdentifierFromComponents:[NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode]];
            NSString *country = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
            [temp addObject: country];
        }
        _dataArray = temp;
    }
    return _dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
