//
//  NetworkSession.h
//  DigDes
//
//  Created by Илья Виноградов on 06.04.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkSession : NSObject
-(void) fetchData: (void(^)(NSMutableArray* arr))completion;
-(void) fetchImageURL:(NSString*)tag :(void(^)(NSMutableArray* arr))completion;
@end

NS_ASSUME_NONNULL_END
