#import "AFFittrClient.h"

static NSString * const kAFFittrAPIBaseURLString = @"http://fittr.com:3000/";
static NSString *const kAFFittrAPICheckUserPath = @"User/checkUser";

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

-(void)commandWithParams:(NSMutableDictionary*)params forPath: (NSString *)path onCompletion:(JSONResponseBlock)completionBlock {
    NSMutableURLRequest*apiRequest =[self multipartFormRequestWithMethod:@"POST"
                                                                    path:path
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

-(void)checkUserWithUsername: (NSString *)username andPassword: (NSString *)password delegate: (id<AFFittrClientDelegate>)delegate {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  username, @"username",
                                  password, @"password",
                                  nil];
    
    //make the call to the web API
    [[AFFittrClient sharedClient] commandWithParams:params forPath:kAFFittrAPICheckUserPath
        onCompletion:^(NSDictionary*json){
            if ([[json valueForKey:@"user_exists"] isEqualToString:@"true"])
                [delegate onCheckUser: true];
            else
                [delegate onCheckUser: false];
    }];
}

@end