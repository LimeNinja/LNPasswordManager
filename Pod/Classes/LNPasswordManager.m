//
//  LNPasswordManager.m
//  embar
//
//  Created by Rob Stokes on 15/09/2014.
//  Copyright (c) 2014 Redsource. All rights reserved.
//

#import "LNPasswordManager.h"

@implementation LNPasswordManager

@synthesize iCloudSyncEnabled, serviceName;

+ (id)standardKeychain {
    static LNPasswordManager *standardKeychain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        standardKeychain = [[self alloc] init];
    });
    return standardKeychain;
}


- (NSMutableDictionary *)createSearchForKey:(NSString *)key {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    NSData *encodedIdentifier = [key dataUsingEncoding:NSUTF8StringEncoding];
    [dict setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [dict setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    
    if (self.serviceName != nil) {
        [dict setObject:self.serviceName forKey:(__bridge id)kSecAttrService];
    }
    
    if (self.iCloudSyncEnabled) {
        [dict setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecAttrSynchronizable];
    }
    return dict;
}


- (NSData *)getKeychainValueForKey:(NSString *)key {
    NSMutableDictionary *dict = [self createSearchForKey:key];
    
    // Add search attributes
    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    // Add search return types
    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef result = NULL;
    
    SecItemCopyMatching((__bridge CFDictionaryRef)dict, (CFTypeRef *)&result);
    return (__bridge NSData *)(result);
}


- (BOOL)createKeychainValue:(NSString *)value forKey:(NSString *)key {
    NSData *passwordData = [self getKeychainValueForKey:key];
    if (passwordData) {
        // Password Exists, therefore update
        return [self updateKeychainValue:value forKey:key];
    } else {
        NSMutableDictionary *dictionary = [self createSearchForKey:key];
        
        NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
        [dictionary setObject:data forKey:(__bridge id)kSecValueData];
        
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
        if (status == errSecSuccess) return YES;
    }
    return NO;
}

- (BOOL)updateKeychainValue:(NSString *)value forKey:(NSString *)key {
    
    NSMutableDictionary *searchDictionary = [self createSearchForKey:key];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (void)deleteKeychainValue:(NSString *)key {
    
    NSMutableDictionary *searchDictionary = [self createSearchForKey:key];
    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
}

-(BOOL)verifyPassword:(NSString *)password forUsername:(NSString *)username {
    NSData *passwordData = [self getKeychainValueForKey:username];
    if (passwordData) {
        NSString *pass = [[NSString alloc] initWithData:passwordData
                                                   encoding:NSUTF8StringEncoding];
        if ([pass isEqualToString:password]) return true;
    }
    return false;
}

-(void)savePassword:(NSString *)password forUsername:(NSString *)username {
    [self createKeychainValue:password forKey:username];
}

@end
