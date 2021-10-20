//
//  Employee.h
//  BindArrayObject
//
//  Created by Chen Xiaohan on 2021/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSObject
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,strong)NSString *address;
@end

NS_ASSUME_NONNULL_END
