//
//  WizSyncInfo.h
//  Wiz
//
//  Created by 朝 董 on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WizApi.h"
#import "WizDbDelegate.h"

@interface WizSyncInfo :WizApi
{
    id <WizDbDelegate> dbDelegate;
}
@property (nonatomic, retain) id<WizDbDelegate> dbDelegate;
@end
