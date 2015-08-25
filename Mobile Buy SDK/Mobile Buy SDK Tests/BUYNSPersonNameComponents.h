//
//  BUYNSPersonNameComponents.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-24.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

@import Foundation;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
@interface BUYNSPersonNameComponents : NSPersonNameComponents

@end
#else
@interface BUYNSPersonNameComponents : NSObject
@end
#endif
