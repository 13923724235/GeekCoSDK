//
//  GKIBeaconLogsCell.m
//  geeksdk-ios
//
//  Created by Jett on 2022/3/25.
//

#import "GKIBeaconLogsCell.h"
#import "Masonry.h"

@interface GKIBeaconLogsCell()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation GKIBeaconLogsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(4);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-4);
        }];
    }
    return self;
}

#pragma mark - setter

- (void)setMessage:(NSString *)message {
    _message = message;
    
    if (message.length > 0) {
        self.contentLabel.text = message;
    }
}

#pragma mark - getter

+ (NSString *)cellIndicator {
    return NSStringFromClass(self);
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor blueColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
