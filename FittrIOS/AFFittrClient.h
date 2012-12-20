#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFNetworking.h"

//API call completion block with result as json
typedef void(^JSONResponseBlock)(NSDictionary* json);

@interface AFFittrClient : AFHTTPClient

//the authorized user
@property(strong, nonatomic)NSDictionary* user;

//check whether there's an authorized user
-(BOOL)isAuthorized;

//send an API command to the server
-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;

+ (AFFittrClient *)sharedClient;

@end