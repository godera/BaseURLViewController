//
//  HDFBaseURLViewController.m
//  newPatient
//
//  Created by Dawn on 14/11/21.
//  Copyright (c) 2014年 haodf.com. All rights reserved.
//

#import "HDFBaseURLViewController.h"
#import "HDFNetworkManager.h"
#import "UIView+GeometryConvenient.h"

@interface HDFBaseURLViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong) NSArray *baseURLs;
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation HDFBaseURLViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseURLs = @[@"http://106.37.180.82:12253",
                                        @"http://106.37.180.82:65518",
                                        @"http://106.37.180.82:65521",
                                        @"http://106.37.180.82:65522",
                                        @"http://106.37.180.82:65523",
                                        @"http://106.37.180.82:65524",
                                        @"http://106.37.180.82:65525",
                                        @"http://106.37.180.82:65526",
                                        @"http://106.37.180.82:65532",
                                        @"http://dev.mobile-api.haodf.com",
                                        @"http://mobile-api.haodf.com"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    CGFloat delta = 20;
    tableView.height -= delta;
    tableView.originY += delta;
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.baseURLs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.baseURLs[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *baseURLString = self.baseURLs[indexPath.row];
    /// 对 baseURLString 设值的时候 医生端需要加  /doctorapi/，患者端不做改动
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.haodf.newPatient"]) {
        [HDFNetworkManager sharedManager].baseURLString = baseURLString;
    }else if ([bundleIdentifier isEqualToString:@"com.haodf.newDoctor"]) {
        [HDFNetworkManager sharedManager].baseURLString = [baseURLString stringByAppendingString:@"/doctorapi/"];
    }else if ([bundleIdentifier isEqualToString:@"com.haodf.doctorhd"]) {
        [HDFNetworkManager sharedManager].baseURLString = [baseURLString stringByAppendingString:@"/doctorapi/"];
    }else{
        exit(0);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(HDFBaseURLViewControllerDidSelectURL)]) {
        [_delegate HDFBaseURLViewControllerDidSelectURL];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"请选择服务器：";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
