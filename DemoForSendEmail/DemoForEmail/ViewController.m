//
//  ViewController.m
//  DemoForEmail
//
//  Created by Rickie_Lambert on 16/11/14.
//  Copyright © 2016年 DemoForExcise. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 必须 真机测试, 且在真机上已经通过真机上的邮件App登陆了邮箱
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor cyanColor];
    btn.frame = CGRectMake(50, 100, 200, 100);
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick
{
    //判断能否发送邮件
    if (![MFMailComposeViewController canSendMail]) {
        return ;
    }
    //实例化一个邮件控制器
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
    
    //设置收件人邮箱, 在下面输入你要发送给对方的email地址
    [mailVC setToRecipients:@[@"xxxxx@icloud.com"]]; // putin your email address
    
    //设置邮件的内容
    [mailVC setMessageBody:@"这是邮件主题" isHTML:YES];
    
    //设置邮件的附件
    UIImage *image = [UIImage imageNamed:@"123.jpg"];
    
    //将图片转化成NSData类型
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //附件内容
    [mailVC addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"123.jpg"];
    
    //设置代理
    [mailVC setMailComposeDelegate:self];
    
    //显示邮件的视图控制器
    [self presentViewController:mailVC animated:YES completion:nil];
}



/*********************** 华丽的分割线 *************************/
/*
#pragma mark - 在应用内发送邮件
//激活邮件功能
- (void)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
        return;
    }
    if (![mailClass canSendMail]) {
        [self alertWithMessage:@"用户没有设置邮件账户"];
        return;
    }
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"eMail主题"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
    [mailPicker setToRecipients: toRecipients];
    //添加抄送
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    [mailPicker setCcRecipients:ccRecipients];
    //添加密送
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    [mailPicker setBccRecipients:bccRecipients];
    
    // 添加一张图片
    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //添加一个pdf附件
    NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
    NSData *pdf = [NSData dataWithContentsOfFile:file];
    [mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
    
    NSString *emailBody = @"<font color='red'>eMail</font> 正文";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentModalViewController:mailPicker animated:YES];
}

- (NSString *)fullBundlePathFromRelativePath:(NSString *)str
{
    NSString *strUse = @"sssssss";
    return strUse;
}

*/

/*********************** 华丽的分割线 *************************/

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    [self alertWithMessage:msg];
}

- (void)alertWithMessage:(NSString *)str
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}



@end
