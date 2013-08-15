//
//  LNRTransport.h

//
//

#import <Foundation/Foundation.h>

@interface LNRTransport : NSObject

@property (nonatomic, copy) void (^completionHandler)(NSData *resData, int statusCode);

- (id)initWithURL:(NSURL *)url andWithDetails:(NSDictionary *)postData;
- (void)makeHTTPRequest;
- (void)makeHTTPPostRequest:(NSString *)body;

@end
