//
//  GKIBeaconScanListInfoCell.h
//  geeksdk-ios
//
//  Created by Jett on 2022/3/15.
//

#import <UIKit/UIKit.h>
#import "GKSceneIBeacon.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKIBeaconScanListInfoCell : UITableViewCell

+ (NSString *)cellIndicator;

@property (nonatomic, strong) GKSceneIBeacon *model;

@end

NS_ASSUME_NONNULL_END
