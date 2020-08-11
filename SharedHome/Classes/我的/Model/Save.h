//
//  Save.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/11.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class User;

@interface Save : NSObject

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;

/**
 *  存储帐号信息
 */
+ (void)saveUser:(User *)user;

/**
 *  获得上次存储的帐号
 *
 */
+ (User *)user;

+ (NSString *)userID;
+ (NSString *)userPhone;
+ (NSString *)userAvatar;
+ (NSString *)userName;
+ (NSString *)loginToken;

+ (BOOL)isLogin;


@end

@interface User : NSObject

@property (nonatomic , copy) NSString              * userID;
@property (nonatomic , copy) NSString              * sessionKey;
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * openId;
@property (nonatomic , copy) NSString              * recommenderNo;
@property (nonatomic , copy) NSString              * idNo;
@property (nonatomic , copy) NSString              * isRealName;
@property (nonatomic , copy) NSString              * userType;
@property (nonatomic , copy) NSString              * state;
@property (nonatomic , copy) NSString              * thirdBind;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * recommender;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * registerSource;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , copy) NSString              * fullName;


@end


NS_ASSUME_NONNULL_END
