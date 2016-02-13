//
//  MemberViewTableViewCell.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "MemberViewTableViewCell.h"

#import "GetUserListResponse.h"

#import "UIKit+AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface MemberViewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation MemberViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(Member*)member
{
    self.nameLabel.text = member.name;
    self.messageLabel.text = @"あ""ぁ""〜";
    
    [self.profileImage setImageWithURL:[NSURL URLWithString:member.profile.image_192]];
    [self.contentView layoutIfNeeded];
}

@end
