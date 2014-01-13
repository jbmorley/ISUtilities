//
//  ISDBOperation.h
//  
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import <Foundation/Foundation.h>

typedef enum {
  ISDBOperationInsert,
  ISDBOperationDelete,
  ISDBOperationUpdate,
  ISDBOperationMove
} ISDBOperation;