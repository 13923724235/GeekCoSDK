//
//  GKIBeaconLogsCell.h
//  geeksdk-ios
//
//  Created by Jett on 2022/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKIBeaconLogsCell : UITableViewCell

@property (nonatomic, copy) NSString *message;

+ (NSString *)cellIndicator;

@end

NS_ASSUME_NONNULL_END
