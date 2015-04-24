//
//  ViewController.m
//  Dispatch
//
//  Created by Moch Xiao on 4/24/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self dispatch_group_async];
    
    [self dispatch_barrier_async];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self dispatch_group_async];
    
    [self dispatch_barrier_async];
}

#pragma mark -

- (void)dispatch_group_async {
    NSString *url = @"http://e.hiphotos.baidu.com/image/pic/item/77094b36acaf2edd37a29c538e1001e93901933d.jpg";
    NSString *url2 = @"http://h.hiphotos.baidu.com/image/w%3D310/sign=ec6529158e5494ee872209181df4e0e1/c8177f3e6709c93d6f74a65d9d3df8dcd0005491.jpg";
    NSString *url3 = @"http://c.hiphotos.baidu.com/image/w%3D310/sign=09252d84cbea15ce41eee60886003a25/7aec54e736d12f2eb326ed614dc2d5628535688b.jpg";
    NSString *url4 = @"http://e.hiphotos.baidu.com/image/w%3D310/sign=b4a9dc0c700e0cf3a0f748fa3a47f23d/cb8065380cd79123b326e56aaf345982b3b780ed.jpg";
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"开始任务1");
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务1");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"开始任务2");
        [[session dataTaskWithURL:[NSURL URLWithString:url2] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务2");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"开始任务3");
        [[session dataTaskWithURL:[NSURL URLWithString:url3] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务3");
        }] resume];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"开始任务4");
        [[session dataTaskWithURL:[NSURL URLWithString:url4] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务4");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });

}


- (void)dispatch_barrier_async {
    NSString *url = @"http://e.hiphotos.baidu.com/image/pic/item/77094b36acaf2edd37a29c538e1001e93901933d.jpg";
    NSString *url2 = @"http://h.hiphotos.baidu.com/image/w%3D310/sign=ec6529158e5494ee872209181df4e0e1/c8177f3e6709c93d6f74a65d9d3df8dcd0005491.jpg";
    NSString *url3 = @"http://c.hiphotos.baidu.com/image/w%3D310/sign=09252d84cbea15ce41eee60886003a25/7aec54e736d12f2eb326ed614dc2d5628535688b.jpg";
    NSString *url4 = @"http://e.hiphotos.baidu.com/image/w%3D310/sign=b4a9dc0c700e0cf3a0f748fa3a47f23d/cb8065380cd79123b326e56aaf345982b3b780ed.jpg";
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure];
    
    dispatch_queue_t queue = dispatch_queue_create("com.foobar.moch", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"开始任务1");
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务1");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);        
        NSLog(@"开始任务2");
        [[session dataTaskWithURL:[NSURL URLWithString:url2] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务2");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    });
    dispatch_barrier_async(queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"开始任务3");
        [[session dataTaskWithURL:[NSURL URLWithString:url3] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务3");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSLog(@"开始任务4");
        [[session dataTaskWithURL:[NSURL URLWithString:url4] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"完成任务4");
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
}



@end
