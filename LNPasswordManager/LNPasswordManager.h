//
//  LNPasswordManager.h
//  embar
//
//  Created by Rob Stokes on 15/09/2014.
//  Copyright (c) 2014 Redsource. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNPasswordManager : NSObject

@property (nonatomic, retain) NSString *serviceName;
@property (nonatomic) BOOL iCloudSyncEnabled;

+ (id)standardKeychain;

- (NSData *)getKeychainValueForKey:(NSString *)key;
- (BOOL)createKeychainValue:(NSString *)value forKey:(NSString *)key;
- (BOOL)updateKeychainValue:(NSString *)value forKey:(NSString *)key;
- (void)deleteKeychainValue:(NSString *)key;

// Helper Methods
-(void)savePassword:(NSString *)password forUsername:(NSString *)username;
-(BOOL)verifyPassword:(NSString *)password forUsername:(NSString *)username;

@end