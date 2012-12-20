#import "AFFittrClient.h"

static NSString * const kAFFittrAPIBaseURLString = @"https://alpha-api.app.net/";

@implementation AFFittrClient

@synthesize user;

+ (AFFittrClient *)sharedClient {
    static AFFittrClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFFittrClient alloc] initWithBaseURL:[NSURL URLWithString:kAFFittrAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

-(AFFittrClient*)init {
    self = [super init];
    
    if(self != nil){
        user = nil;
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

-(BOOL)isAuthorized {
    return[[user objectForKey:@"IdUser"] intValue]>0;
}

-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock {
    NSMutableURLRequest*apiRequest =[self multipartFormRequestWithMethod:@"POST"
                                                                    path:kAFFittrAPIBaseURLString
                                                              parameters:params
                                               constructingBodyWithBlock:^(id <AFMultipartFormData>formData){
                                                   //TODO: attach file if needed
                                               }];
    
    AFJSONRequestOperation* operation =[[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        //success!
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError*error){//failure :(
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
    
    [operation start];
}

@end