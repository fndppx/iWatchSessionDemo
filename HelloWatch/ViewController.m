//
//  ViewController.m
//  HelloWatch
//
//  Created by keyan on 15/10/14.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>
@interface ViewController ()<WCSessionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *defaultImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *reciveLabel;
@property (nonatomic,strong) WCSession *session;
@property (nonatomic,strong) NSDictionary *applicationDict;
@property (nonatomic,strong) NSDictionary *contentApplicationDict;
@property (nonatomic,strong) NSDictionary *userInfoapplicationDict;
@property (nonatomic,strong) NSDictionary *fileApplicationDict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    _applicationDict = @{@"test":@"😄😄😄😄"};
    _contentApplicationDict = @{@"test":@"这个是上下文消息"};
    _userInfoapplicationDict = @{@"test":@"这个userInfo消息"};
    _fileApplicationDict = @{@"test":@"这个是文件消息"};

    if ([WCSession isSupported]) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
        [self.session activateSession];
    }
    // Do any additional setup after loading the view, typically from a nib.
}
//交互消息
- (IBAction)sendMessage:(id)sender {
    NSDictionary *applicationDict = @{@"test":@"😄😄😄😄"};
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"111能够到达");
        [self.session sendMessage:applicationDict replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            NSLog(@"%@",replyMessage);
            
        } errorHandler:^(NSError * _Nonnull error) {
            
            //所有报错信息
            //        typedef NS_ENUM(NSInteger, WCErrorCode) {
            //            WCErrorCodeGenericError                         = 7001,
            //            WCErrorCodeSessionNotSupported                  = 7002,
            //            WCErrorCodeSessionMissingDelegate               = 7003,
            //            WCErrorCodeSessionNotActivated                  = 7004,
            //            WCErrorCodeDeviceNotPaired                      = 7005,
            //            WCErrorCodeWatchAppNotInstalled                 = 7006,
            //            WCErrorCodeNotReachable                         = 7007,
            //            WCErrorCodeInvalidParameter                     = 7008,
            //            WCErrorCodePayloadTooLarge                      = 7009,
            //            WCErrorCodePayloadUnsupportedTypes              = 7010,
            //            WCErrorCodeMessageReplyFailed                   = 7011,
            //            WCErrorCodeMessageReplyTimedOut                 = 7012,
            //            WCErrorCodeFileAccessDenied                     = 7013,
            //            WCErrorCodeDeliveryFailed                       = 7014,
            //            WCErrorCodeInsufficientSpace                    = 7015,
            //        } NS_ENUM_AVAILABLE_IOS(9_0);
            NSLog(@"%@",error);
            
        }];

    }
       //data数据
//    [self.session sendMessageData:<#(nonnull NSData *)#> replyHandler:^(NSData * _Nonnull replyMessageData) {
//        
//    } errorHandler:^(NSError * _Nonnull error) {
//        
//    }];

}

//上下文消息
- (IBAction)sendContentMessage:(id)sender {
    [self.session updateApplicationContext:_contentApplicationDict error:nil];
}
//userInfo消息
- (IBAction)userInfoMessage:(id)sender {
    [self.session transferUserInfo:_userInfoapplicationDict];

}
//文件消息
- (IBAction)fileMessage:(id)sender {
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    NSURL * url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",path,@"hongxin.png"]];
    if (url!=nil) {
       [[WCSession defaultSession] transferFile:url metadata:_fileApplicationDict];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//1.Application Context
- (void)session:(nonnull WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    
   
    
    NSString *emoji = [applicationContext objectForKey:@"test"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.reciveLabel setText:[NSString stringWithFormat:@"%@",emoji]];
    });
}
//2.文件传输
- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error
{
    
}
//2.文件传输完成调用这个好像文件传不过来不知道为什么
- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    NSLog(@"iWatch的文件路径--%@文件数据--%@",file.fileURL,file.metadata);
   

    dispatch_async(dispatch_get_main_queue(), ^{
        self.reciveLabel.text = [NSString stringWithFormat:@"iWatch的文件路径--%@文件数据--%@",file.fileURL,file.metadata];
    });
    
   
}
//3.用户信息传递
- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo
{
    NSString *emoji = [userInfo objectForKey:@"test"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.reciveLabel setText:[NSString stringWithFormat:@"%@",emoji]];
    });
}

//4.data数据
- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void(^)(NSData *replyMessageData))replyHandler
{
    
}

// 5.普通 Message
- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler
{
    
    NSString *emoji = [message objectForKey:@"test"];

    dispatch_async(dispatch_get_main_queue(), ^{
        self.reciveLabel.text = [NSString stringWithFormat:@"%@", emoji];
    });
    
    replyHandler(@{@"reply" : @"OK"});
}

//删除火关闭app的时候调用
- (void)sessionWatchStateDidChange:(WCSession *)session
{
    
}

@end
