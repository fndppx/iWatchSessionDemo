//
//  InterfaceController.m
//  HelloWatchApp Extension
//
//  Created by keyan on 15/10/14.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "TwoInterfaceController.h"
@interface InterfaceController()<WCSessionDelegate>
{
//    NSDictionary *applicationDict;
}
@property (strong, nonatomic) WCSession *session;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (nonatomic,strong) NSDictionary *applicationDict;
@property (nonatomic,strong) NSDictionary *contentApplicationDict;

@property (nonatomic,strong) NSDictionary *userInfoapplicationDict;

@property (nonatomic,strong) NSDictionary *fileApplicationDict;

@end


@implementation InterfaceController
-(instancetype)init {
    self = [super init];
    
    if (self) {
        _applicationDict = @{@"test":@"😄😄😄😄"};
        _contentApplicationDict = @{@"test":@"这个是上下文消息"};
        _userInfoapplicationDict = @{@"test":@"这个userInfo消息"};
        _fileApplicationDict = @{@"test":@"这个是文件消息"};
        if ([WCSession isSupported]) {
            self.session = [WCSession defaultSession];
            self.session.delegate = self;
            [self.session activateSession];
        }
    }
    return self;
}
- (IBAction)gotoNext {
    
//    TwoInterfaceController * twoVC = [[TwoInterfaceController alloc]init];
    [self pushControllerWithName:@"TwoInterfaceController" context:nil];
//    [self presentControllerWithName:@"TwoInterfaceController" context:nil];
}
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self.titleLabel setText:@"Hello world"];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
//userinfo消息
- (IBAction)userInfoAction {
    [self.session transferUserInfo:_userInfoapplicationDict];

}
//文件消息
- (IBAction)fileAction {
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSURL * url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",path,@"hongxin.png"]];
//        NSURL * url = [NSURL URLWithString:@"http://i3.letvimg.com/lc03_isvrs/201509/08/14/45/fa4af9bfae23498f9cce2ffb9c7aa59a2325090750077630335.jpg"];
    if (url!=nil) {
        [[WCSession defaultSession] transferFile:url metadata:_fileApplicationDict];
        
    }
}
//上下文消息
- (IBAction)contentAction {
//     [self.session updateApplicationContext:_contentApplicationDict error:nil];
    
    [self pushControllerWithName:@"MenuInterfaceController" context:nil];
}

//普通消息
- (IBAction)sendMessageAction
{
//    // 您可以通过访问属性来确定是否能够到达。
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"能够到达");
        [self.session sendMessage:_applicationDict replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            
        } errorHandler:^(NSError * _Nonnull error) {
            
        }];
    }
   
//    if ([[WCSession defaultSession] isReachable]) {
//        NSLog(@"能够到达");
////        WKImage * image = [WKImage imageWithImageName:@"hongxin.png"];
//        [self.session sendMessageData:nil replyHandler:^(NSData * _Nonnull replyMessageData) {
//            
//        } errorHandler:^(NSError * _Nonnull error) {
//            
//        }];
//    }
    
}


//状态改变
- (void)sessionReachabilityDidChange:(WCSession *)session
{
    NSLog(@"关闭了");
}

//接受信息
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message
{
    
}
//收到普通消息
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    NSString *emoji = [message objectForKey:@"test"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.titleLabel setText:[NSString stringWithFormat:@"%@",emoji]];
    });
 
    
    replyHandler(@{@"reply" : @"OK"});
}



//1.Application Context
- (void)session:(nonnull WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    
    
    
    NSString *emoji = [applicationContext objectForKey:@"test"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.titleLabel setText:[NSString stringWithFormat:@"%@",emoji]];
    });
}
//2.文件传输
- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error
{
    
}
//文件传输完成调用
- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    NSLog(@"%@",file);
    
}
//3.用户信息传递
- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo
{
    NSString *emoji = [userInfo objectForKey:@"test"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.titleLabel setText:[NSString stringWithFormat:@"%@",emoji]];
    });
}


//4.收到data数据
- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData
{
    
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void(^)(NSData *replyMessageData))replyHandler
{
    
}

@end



