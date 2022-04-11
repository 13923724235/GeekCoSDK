//
//  NSArray+GeekSafa.m
//  geeksdk-ios
//
//  Created by Jett on 2022/4/2.
//

#import "NSArray+GeekSafa.h"

@implementation NSArray (GeekSafa)

#pragma mark - Safe

- (id)safeAtIndex:(NSUInteger)index {
    index = MIN(index, self.count - 1);
    return [self objectAtIndex:index];
}

#pragma mark - Block

- (void)forEach:(void (^)(id))body
{
    for (id element in self) {
        body(element);
    }
}

- (NSArray <id>*)select:(BOOL (^)(id))where
{
    __block NSArray *array = @[];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (where(obj)) {
            array = [array arrayByAddingObject:obj];
        }
    }];
    if (array.count == 0)
        return nil;
    return array;
}

- (nullable id)selectOne:(BOOL (^)(id obj))where {
    __block id selectedObj = nil;
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (where(obj)) {
            selectedObj = obj;
            *stop = YES;
        }
    }];
    return selectedObj;
}

- (NSArray <id>*)reject:(BOOL (^)(id))where
{
    return [self select:^BOOL(id obj) {
        return !where(obj);
    }];
}

- (id)reduce:(id)initial body:(id (^)(id, id))body
{
    NSParameterAssert(body != nil);
    
    __block id result = initial;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = body(result, obj);
    }];
    
    return result;
}

- (NSArray *)flatMap:(id _Nullable (^)(id _Nonnull))body
{
    NSParameterAssert(body != nil);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = body(obj);
        if (value) [result addObject:value];
    }];
    
    return [result copy];
}

- (BOOL)contain:(BOOL (^)(id))where {
    
    __block BOOL res = NO;
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (where(obj)) {
            *stop = YES;
            res = YES;
        }
    }];
    
    return res;
}

#pragma mark - Select

- (NSArray *)random {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return arc4random() % 2 == 0 ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (NSArray *)combineWithCount:(NSUInteger)count {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *res = [NSMutableArray array];
    
    // 防止 block 递归调用循环引用
    __block void (^combine)(NSUInteger, NSUInteger, NSUInteger);
    __block __weak void (^weakCombine)(NSUInteger, NSUInteger, NSUInteger);
    
    weakCombine = combine = ^(NSUInteger count, NSUInteger begin, NSUInteger index) {
        if (count == 0) { [res addObject:array.copy]; return; }
        
        for (NSUInteger i = begin; i < self.count; ++i) {
            array[index] = self[i];
            weakCombine(count - 1, i + 1, index + 1);
        }
    };
    combine(count, 0, 0);
    return [res copy];
}


#pragma mark - Sort

- (NSArray *)reversed
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)sorted
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 compare:obj2];}];
    return resultArray;
}

- (NSArray *)sortedCaseInsensitive
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 caseInsensitiveCompare:obj2];}];
    return resultArray;
}

- (NSMutableArray *)bubbleSort
{
    NSMutableArray *originArray = [NSMutableArray arrayWithArray:self];
    
    NSInteger count = [originArray count];
    for (int i = 0; i < count; i++) {
        for (int j = 0; j < count - i - 1; j++) {
            if([[originArray objectAtIndex:j] compare:[originArray objectAtIndex:j + 1] options:NSNumericSearch] == -1){  //potions  NSNumericSearch = 64,
                [originArray exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
            }
        }
    }
    
    return originArray;
}

#pragma mark - JSONString

- (NSString *)toJSONString {
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    }else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
