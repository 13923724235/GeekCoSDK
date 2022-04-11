//
//  GKIBeaconScanListInfoVC.m
//  geeksdk-ios
//
//  Created by Jett on 2022/3/15.
//

#import "GKIBeaconScanListInfoVC.h"
#import "GKIBeaconScanListInfoCell.h"
#import "GKIBeaconLogsCell.h"
#import "NSArray+GeekSafa.h"
#import <GeekMXSDK/GeekSDKManager.h>
#import <UserNotifications/UserNotifications.h>
#import <YYModel/YYModel.h>
#import "Masonry.h"

@interface GKIBeaconScanListInfoVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *iBeaconList;
@property (nonatomic, strong) NSMutableArray *logMessages;
@property (nonatomic, assign) int currentTime;

@end

@implementation GKIBeaconScanListInfoVC

#pragma mark - getter

- (NSMutableArray *)iBeaconList {
    
    if (!_iBeaconList) {
        
        _iBeaconList = [NSMutableArray array];
    }
    return _iBeaconList;
}

- (NSMutableArray *)logMessages {
    
    if (!_logMessages) {
        
        _logMessages = [NSMutableArray array];
    }
    return _logMessages;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[GKIBeaconScanListInfoCell class] forCellReuseIdentifier:[GKIBeaconScanListInfoCell cellIndicator]];
        [_tableView registerClass:[GKIBeaconLogsCell class] forCellReuseIdentifier:[GKIBeaconLogsCell cellIndicator]];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"IBeacon List";
    self.view.backgroundColor = [UIColor lightGrayColor];
        
    [self setupTableView];
    [self updateServiceData];
    [self addServiceNotification];
}

- (void)setupTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addServiceNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearIBeaconList) name:@"CLEAR_IBEACON_LIST" object:nil];
}

- (void)updateServiceData {
    
    __weak typeof(self) weakSelf = self;
    [GeekSDKManager sharedInstance].sceneIBeaconBlock = ^(NSDictionary * _Nonnull iBeaconInfo) {
        if (iBeaconInfo && [iBeaconInfo isKindOfClass:[NSDictionary class]]) {
            GKSceneIBeacon *iBeacon = [GKSceneIBeacon yy_modelWithDictionary:iBeaconInfo];
            [self.iBeaconList addObject:iBeacon];
            [self findBeaconSendBody:iBeacon.uuid];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf scrollToTopAnimated:YES];
    };
    
    [GeekSDKManager sharedInstance].iBeaconLogBlock = ^(NSString * _Nonnull logMessage) {
        if (logMessage.length > 0) {
            [weakSelf.logMessages addObject:logMessage];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf scrollToTopAnimated:YES];
    };
}

- (void)clearIBeaconList {
    if (self.iBeaconList.count > 0) {
        [self.iBeaconList removeAllObjects];
    }
    
    [self.tableView reloadData];
}

- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint offset = self.tableView.contentOffset;
    offset.y = self.tableView.contentSize.height - self.tableView.bounds.size.height + self.tableView.contentInset.bottom;
    [self.tableView setContentOffset:offset animated:animated];
}

#pragma mark - UNUserNotificationCenter

- (void)findBeaconSendBody:(NSString *)body {
    
    if (self.currentTime == 0) {
        self.currentTime = [[NSDate date] timeIntervalSince1970];
        [self sendLocalNotice:body];
    }else {
        int endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - self.currentTime >= 30) {
            self.currentTime = endTime;
            [self sendLocalNotice:body];
        }else {
            self.currentTime = endTime;
        }
    }
}

/// 发送本地推送通知
/// @param body 通知内容
- (void)sendLocalNotice:(NSString *)body {
    
    [self bounceLocalNoticeWithTitle:@"发现beacon设备" subtitle:@"" body:body];
}

- (void)bounceLocalNoticeWithTitle:(NSString *)title
                          subtitle:(NSString *)subtitle
                              body:(NSString *)body {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = title;
        content.subtitle = subtitle;
        // 内容
        content.body = [NSString stringWithFormat:@"%@", body];
        // 默认声音
        //content.sound = [UNNotificationSound defaultSound];
        // 添加自定义声音
        content.sound = [UNNotificationSound soundNamed:@"Alert_ActivityGoalAttained_Salient_Haptic.caf"];
        // 角标 （我这里测试的角标无效，暂时没找到原因）
        content.badge = @1;
        // 多少秒后发送,可以将固定的日期转化为时间
        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:10] timeIntervalSinceNow];
        //NSTimeInterval time = 10;
        // repeats，是否重复，如果重复的话时间必须大于60s，要不会报错
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
        // 添加通知的标识符，可以用于移除，更新等操作
        NSString *identifier = @"noticeId";
        // 通知请求
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        // 添加通知
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            //NSLog(@"Notification error：%@", error);
        }];
    }
}

#pragma mark - <UITableViewiBeaconList && Delegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.iBeaconList.count;
    }
    return self.logMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GKIBeaconScanListInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[GKIBeaconScanListInfoCell cellIndicator]];
        if (self.iBeaconList.count > indexPath.row) {
            cell.model = [self.iBeaconList safeAtIndex:indexPath.row];
        }
        return cell;
    }else {
        GKIBeaconLogsCell *cell = [tableView dequeueReusableCellWithIdentifier:[GKIBeaconLogsCell cellIndicator]];
        if (self.logMessages.count > indexPath.row) {
            cell.message = [self.logMessages safeAtIndex:indexPath.row];
        }
        return cell;
    }
}

@end
