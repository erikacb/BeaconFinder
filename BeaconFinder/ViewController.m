//
//  ViewController.m
//  BeaconFinder
//
//  Created by Erika Bueno on 28/07/16.
//  Copyright © 2016 Erika Bueno. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconDetails.h"
#import "BeaconDetailsCloudFactory.h"
#import "CachingContentFactory.h"
#import "ProximityContentManager.h"

@interface ViewController () <ProximityContentManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UIImageView *beacon;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic) ProximityContentManager *proximityContentManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activity startAnimating];
    
    NSArray *beacons = [[NSArray alloc] init];
    
    beacons = @[
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:24850 minor:21327], // lemon
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:23065 minor:11445], // beetroot
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:58564 minor:12579], // candy
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:47311 minor:64074], // candy
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:40148 minor:35356], // lemon
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:43509 minor:59347], // beetroot
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:51666 minor:16268], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:52863 minor:63165], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:21796 minor:22145], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:36105 minor:39424], // blueberry
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:30981 minor:44032], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:13523 minor:17363], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:47730 minor:48196], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:5754  minor:25494], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:45842 minor:30039], // blueberry
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:52730 minor:34692], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:22656  minor:5070], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:27015 minor:61122], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:4239  minor:25563], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:3277  minor:62245], // blueberry
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:29284 minor:60640], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:43503 minor:14403], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:19321  minor:5669], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:7078   minor:3223], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:41089 minor:32209], // blueberry
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:35957 minor:30921], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:1365  minor:50274], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:47764  minor:7049], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:59892  minor:9069], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:11903 minor:6819],  // blueberry
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:39879 minor:50249], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:56774 minor:32213], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:50568 minor:62319], // mint
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:26392   minor:476], // ice
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:57895 minor:51797], // mint

                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:54899 minor:20608], // mint
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:52502 minor:21937], // mint
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:18239 minor:55634], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:22963 minor:32043], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:27855  minor:9614], // ice
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:32057   minor:753], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:32247 minor:15353], // mint
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:52189 minor:42725], // ice
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:50945 minor:28058], // ice
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:9551  minor:59915], // blueberry
                
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:36298  minor:62875], // ice
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:44648  minor:33805], // blueberry
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:17458  minor:2324],  // mint
                [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:56626  minor:42333]  // ice
                ];
    
    self.proximityContentManager = [[ProximityContentManager alloc] initWithBeaconIDs:beacons beaconContentFactory:[[CachingContentFactory alloc] initWithBeaconContentFactory:[BeaconDetailsCloudFactory new]]];
    
    self.proximityContentManager.delegate = self;
    
    [self.proximityContentManager startContentUpdates];
}

- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
    
    [self.activity stopAnimating];
    
    [self.activity removeFromSuperview];
    
    BeaconDetails *beaconDetails = content;
    
    if (beaconDetails) {
        
        self.view.backgroundColor = beaconDetails.backgroundColor;
        
        self.info.text = [NSString stringWithFormat:@"Hello, I'm %@!", beaconDetails.beaconName];
        
        self.beacon.hidden = NO;
        
    } else {
        
        self.view.backgroundColor = BeaconDetails.neutralColor;
        
        self.info.text = @"Where are you, beacons?";
        
        self.beacon.hidden = YES;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
