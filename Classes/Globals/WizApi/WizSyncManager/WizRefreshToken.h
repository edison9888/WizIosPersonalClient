//
//  WizRefreshToken.h
//  Wiz
//
//  Created by 朝 董 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WizApi.h"
#import "WizRefreshDelegate.h"

@interface WizRefreshToken : WizApi <UIAlertViewDelegate>
{
    id <WizRefreshDelegate> refreshDelegate;
}
@property (nonatomic, assign) id <WizRefreshDelegate> refreshDelegate;
@end
