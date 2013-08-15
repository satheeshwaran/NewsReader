//
//  LNRTransport.m
//
//

#import "LNRTransport.h"

@interface LNRTransport()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSDictionary *dataToTransport;
@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic) int statusCode;

@end

@implementation LNRTransport

- (id)initWithURL:(NSURL *)url andWithDetails:(NSDictionary *)postData {
    
    if ((self = [super init])) {
        
        self.url =url;
        self.dataToTransport = postData;
    }
    return self;
}


- (void)makeHTTPRequest {
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.urlConnection = conn;
}

- (void)makeHTTPPostRequest:(NSString *)body {
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    self.responseData =  [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    NSArray *keys = [self.dataToTransport allKeys];
    for (int i = 0; i< [keys count]; i++) {
        [request addValue:[self.dataToTransport objectForKey:[keys objectAtIndex:i]] forHTTPHeaderField:[keys objectAtIndex:i]];
    }
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self] ;
    self.urlConnection = conn;
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    self.statusCode = [httpResponse statusCode];
    NSLog(@"STATUS CODE:%d",self.statusCode);
    [self.responseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
	// Clear the responsedata property to allow later attempts
    self.responseData = nil;
    
    // Release the connection now that it's finished
    self.urlConnection = nil;
    
    // call our delegate and tell it that connection failed with empty data
    if (self.completionHandler)
        self.completionHandler([self.responseData copy],self.statusCode);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    // Release the connection now that it's finished
    self.urlConnection = nil;
    NSString *theXML = [[NSString alloc] initWithBytes: [self.responseData mutableBytes] length:[self.responseData length] encoding:NSUTF8StringEncoding];
    NSLog(@"Response XML : %@", theXML);
    // call our delegate and tell it that connection completed
    if (self.completionHandler)
        self.completionHandler([self.responseData copy],self.statusCode);
}



@end
