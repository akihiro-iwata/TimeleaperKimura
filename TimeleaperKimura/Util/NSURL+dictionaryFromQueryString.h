//
//  NSURL+dictionaryFromQueryString.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/07.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSURL (dictionaryFromQueryString)
-(NSDictionary *) dictionaryFromQueryString;
@end