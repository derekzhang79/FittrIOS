#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFNetworking.h"

//API call completion block with result as json
typedef void(^JSONResponseBlock)(NSDictionary* json);

@protocol AFFittrClientDelegate <NSObject>

@optional

//Called when a checkUserWithUsername:andPassword is sent through
-(void)onCheckUser:(BOOL)res;

@end

@interface AFFittrClient : AFHTTPClient

//the authorized user
@property(strong, nonatomic)NSDictionary* user;

//Send an API command to the server
-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;

//Check if user exists
-(void)checkUserWithUsername: (NSString *)username andPassword: (NSString *)password delegate: (id<AFFittrClientDelegate>)delegate;

+ (AFFittrClient *)sharedClient;

@end