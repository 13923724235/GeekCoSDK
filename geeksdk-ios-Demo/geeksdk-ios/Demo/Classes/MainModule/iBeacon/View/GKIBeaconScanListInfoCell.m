//
//  GKIBeaconScanListInfoCell.m
//  geeksdk-ios
//
//  Created by Jett on 2022/3/15.
//

#import "GKIBeaconScanListInfoCell.h"
#import "Masonry.h"

@interface GKIBeaconScanListInfoCell()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *uuidLabel;
@property (nonatomic, strong) UILabel *proximity;
@property (nonatomic, strong) UILabel *majorLabel;
@property (nonatomic, strong) UILabel *minorLabel;
@property (nonatomic, strong) UILabel *accuracyLabel;
@property (nonatomic, strong) UILabel *rssiLabel;

@end

@implementation GKIBeaconScanListInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.uuidLabel];
        [self.containerView addSubview:self.proximity];
        [self.containerView addSubview:self.majorLabel];
        [self.containerView addSubview:self.minorLabel];
        [self.containerView addSubview:self.accuracyLabel];
        [self.containerView addSubview:self.rssiLabel];
        
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.left.equalTo(self.contentView).offset(14);
            make.right.equalTo(self.contentView).offset(-14);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
        
        [self.uuidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView).offset(8);
            make.left.equalTo(self.containerView).offset(14);
            make.right.equalTo(self.containerView).offset(-14);
        }];
        
        [self.proximity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.uuidLabel.mas_bottom).offset(8);
            make.left.equalTo(self.containerView).offset(14);
            make.right.equalTo(self.containerView).offset(-14);
        }];
        
        [self.majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.proximity.mas_bottom).offset(8);
            make.left.right.equalTo(self.uuidLabel);
        }];
        
        [self.minorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.majorLabel.mas_bottom).offset(8);
            make.left.right.equalTo(self.uuidLabel);
        }];
        
        [self.accuracyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.minorLabel.mas_bottom).offset(8);
            make.left.right.equalTo(self.uuidLabel);
        }];
        
        [self.rssiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accuracyLabel.mas_bottom).offset(8);
            make.bottom.equalTo(self.containerView).offset(-15);
            make.left.right.equalTo(self.uuidLabel);
        }];
    }
    return self;
}


#pragma mark - setter

- (void)setModel:(GKSceneIBeacon *)model {
    _model = model;
    
    self.uuidLabel.text = [NSString stringWithFormat:@"UUID：%@", model.uuid];
    self.proximity.text = [NSString stringWithFormat:@"status：%@", model.proximity];
    self.majorLabel.text = [NSString stringWithFormat:@"major：%@", model.major];
    self.minorLabel.text = [NSString stringWithFormat:@"minor：%@", model.minor];
    
    self.accuracyLabel.text = [NSString stringWithFormat:@"accuracy：%f", model.accuracy];
    self.rssiLabel.text = [NSString stringWithFormat:@"rssi：%ld", model.rssi];
}

#pragma mark - getter

+ (NSString *)cellIndicator {
    return NSStringFromClass(self);
}

- (UILabel *)uuidLabel {
    
    if (!_uuidLabel) {
        _uuidLabel = [[UILabel alloc] init];
        _uuidLabel.textColor = [UIColor orangeColor];
        _uuidLabel.font = [UIFont systemFontOfSize:17];
        _uuidLabel.numberOfLines = 0;
        _uuidLabel.text = [NSString stringWithFormat:@"UUID：--"];
        
    }
    return _uuidLabel;
}

- (UILabel *)proximity {
    
    if (!_proximity) {
        _proximity = [[UILabel alloc] init];
        _proximity.textColor = [UIColor blueColor];
        _proximity.font = [UIFont systemFontOfSize:15];
        _proximity.numberOfLines = 0;
        _proximity.text = [NSString stringWithFormat:@"status：--"];
    }
    return _proximity;
}


- (UILabel *)majorLabel {
    
    if (!_majorLabel) {
        _majorLabel = [[UILabel alloc] init];
        _majorLabel.textColor = [UIColor lightGrayColor];
        _majorLabel.font = [UIFont systemFontOfSize:14];
        _majorLabel.numberOfLines = 0;
        _majorLabel.text = [NSString stringWithFormat:@"major：--"];
    }
    return _majorLabel;
}

- (UILabel *)minorLabel {
    
    if (!_minorLabel) {
        _minorLabel = [[UILabel alloc] init];
        _minorLabel.textColor = [UIColor lightGrayColor];
        _minorLabel.font = [UIFont systemFontOfSize:14];
        _minorLabel.numberOfLines = 0;
        _minorLabel.text = [NSString stringWithFormat:@"minor：--"];
    }
    return _minorLabel;
}

- (UILabel *)accuracyLabel {
    
    if (!_accuracyLabel) {
        _accuracyLabel = [[UILabel alloc] init];
        _accuracyLabel.textColor = [UIColor lightGrayColor];
        _accuracyLabel.font = [UIFont systemFontOfSize:14];
        _accuracyLabel.numberOfLines = 0;
        _accuracyLabel.text = [NSString stringWithFormat:@"accuracy：--"];
    }
    return _accuracyLabel;
}

- (UILabel *)rssiLabel {
    
    if (!_rssiLabel) {
        _rssiLabel = [[UILabel alloc] init];
        _rssiLabel.textColor = [UIColor lightGrayColor];
        _rssiLabel.font = [UIFont systemFontOfSize:14];
        _rssiLabel.numberOfLines = 0;
        _rssiLabel.text = [NSString stringWithFormat:@"rssi：--"];
    }
    return _rssiLabel;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.borderWidth = 1;
        _containerView.layer.borderColor = [[UIColor blueColor] CGColor];
    }
    return _containerView;
}

@end
