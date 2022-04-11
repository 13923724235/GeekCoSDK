//
//  NSArray+GeekSafa.h
//  geeksdk-ios
//
//  Created by Jett on 2022/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (GeekSafa)

/// 防止取值时数组越界
/// @param index 索引
- (id)safeAtIndex:(NSUInteger)index;

- (void)forEach:(void (^)(id))body;
- (NSArray <id>*)select:(BOOL (^)(id))where;
- (nullable id)selectOne:(BOOL (^)(id obj))where;
- (NSArray <id>*)reject:(BOOL (^)(id))where;
- (id)reduce:(id)initial body:(id (^)(id, id))body;
- (NSArray *)flatMap:(id _Nullable (^)(id _Nonnull))body;
- (BOOL)contain:(BOOL (^)(id))where;


- (NSArray *)random;
- (NSArray *)combineWithCount:(NSUInteger)count;

- (NSArray *)reversed;
- (NSArray *)sorted;
- (NSArray *)sortedCaseInsensitive;
- (NSMutableArray *)bubbleSort;

- (NSString *)toJSONString;

@end

NS_ASSUME_NONNULL_END
