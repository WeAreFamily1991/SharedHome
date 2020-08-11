//
//  Save.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/11.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "Save.h"
#define kMessagePath(path) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path]

@implementation Save

+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    //存储数据
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    //立刻同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)objectForKey:(NSString *)defaultName
{
    //利用NSUserDefaults，就能直接访问软件的偏好设置（Lobarary/Preferences）
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}


/**
 *  存储帐号信息
 */
+ (void)saveUser:(User *)user
{
    [NSKeyedArchiver archiveRootObject:user toFile:kMessagePath(@"user.plist")];
}

/**
 *  获得上次存储的帐号
 *
 */
+ (User *)user
{
    User *user = [NSKeyedUnarchiver unarchiveObjectWithFile:kMessagePath(@"user.plist")];
    
    return user;
}

+ (NSString *)userID
{
    User *user = [self user];
    
    return user.userID;
}

+ (BOOL)isLogin
{
    User *user = [self user];
    if (!user.userID || user.userID.length==0) {
        return NO;
    }
    return YES;
}

+ (NSString *)userAvatar
{
    User *user = [self user];
    
    return user.avatar;
}

+ (NSString *)userPhone
{
    User *user = [self user];
    
    return user.phone;

}

+ (NSString *)userName
{
    User *user = [self user];
    return user.userName;
}

+ (NSString *)loginToken
{
    User *user = [self user];
    return user.token;
}



@end



@implementation User

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"userID":@"id"
             };
}

- (NSString *)avatar
{
    if (!_avatar) {
        _avatar = @"";
    }
    else if (![_avatar containsString:@"http"])
    {
       // _headPic = [NSString stringWithFormat:@"%@%@", LINEURL,_headPic];
    }
    return _avatar;
}
- (NSString *)userName
{
    if (!_userName) {
        _userName = @"";
    }
    return _userName;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([User class], &count);
    for (int index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([User class], &count);
        for (int index = 0; index < count; index ++) {
            Ivar ivar = ivars[index];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];
        }
    }
    return self;
}

@end
