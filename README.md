# TBRJSONMapper
## Automatic JSON to model object mapper

TBRJSONMapper is an Objective-C (with Swift support) library for mapping JSON into model data classes while writing as little code as possible.

The main idea is that by following a set of conventions, you do not need to specify what property in the JSON file matches what model object. Doing this can save huge  amounts of time during prototyping or if you control both the server API (or other JSON source) and the iOS client.

Accompanying this documentation is a set of examples both in Swift and Objective-C.

# Installation

To use TBRJSONMapper on your app, simply drag the TBRJSONMapper class files (.m and .h) into your project and import the header where neccessary. If you're using swift, import the header file into your bridging header.

# Usage

Let's assume you have the following JSON file that you wish to map to Objective-C / iOS classes:

```
{
	"Address" : {
		"name" : "John Doe",
		"email" : "john@doeind.com",
		"partTime" : false,
		"Phones" : [
					    {
                            "type" : "office",
                            "number" : "01234 56789"
                        },
                	    {
                            "type" : "mobile",
                            "number" : "0777 9874 321"
                        },
                   	    {
                            "type" : "home",
                            "number" : "1124 7153 060"
                        }
                   ]
	}
}
```


### 1. Create a new class for Address (see below), and another one for Phone.

#### Objective-C
```objc
//Address.h
#import <Foundation/Foundation.h>
@interface Address : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *email;
@property (strong, nonatomic) NSNumber *partTime;

// One-to-many relationship
@property (strong, nonatomic) NSArray *phones;

@end

// Address.m
@implementation Address

@end

```

#### Swift
```swift
import Foundation

class Address: NSObject {
    var name: String
    var email: String
    var phones: [Phone]
    
    override init() {
        self.name = ""
        self.email = ""
    }
}
```

### 2. Map your JSON into your model objects:

#### Objective-C
```objc
TBRJSONMapper *mapper = [[TBRJSONMapper alloc] init];
NSString *JSONFileInMainBundle = @"address";
Address *topAddress = [mapper objectGraphForJSONResource:JSONFileInMainBundle
                                       withRootClassName:@"Address"];
```

#### Swift
```swift
 let mapper = TBRJSONMapper(swiftModuleName: "SwiftExample")
 let filename = "address"
 let recipe = mapper.objectGraphForJSONResource(filename, withRootClassName: "Address") as! Address
```

# Conventions

- There must be a root class in the JSON file, this will be the class returned to you.
- Classes start with a capital.
- Arrays (one-to-many relationships) end up with an s, i.e. 'Steps'.


# Methods

These are all of the methods available in TBRJSONMapper:


```
- (instancetype)initWithSwiftModuleName:(NSString *)swiftModuleName;
```

When using TBRJSONMapper with swift, use this initializer to pass your project's module name.


```
- (id)objectGraphForJSONResource:(NSString *)resourcePath withRootClassName:(NSString *)className;
```
Use this method to get the root object with class `className` when your JSON file is stored in your main bundle. 

```
- (id)objectGraphForJSONData:(NSData *)data withRootClassName:(NSString*)className;
```

If you have already converted your JSON into NSData (for example, during archiving) use this method to map its content into your model. It returns the root object in the JSON object.

```
- (id)objectGraphForDownloadedJSONResourcePath:(NSString *)resourceName withRootClassName:(NSString *)className;
```

If you are storing a JSON file in some other directory other than your main bundle (for example, if your app has downloaded it from a server), you can use this method to pass a string containing the direct path to the JSON file (`resourceName`) as well as the root class name. It will return the mapped top-level object.


# Swift compatibility

The mapper has been tested a well as used in production with Swift.

In order to use it from Swift, you must pass the swift module name to the initializer, like this: `TBRJSONMapper(swiftModuleName: "SwiftExample")`. 

Your swift model classes must also inherit from `NSObject`.


# FAQ
#### What happens if a key in JSON has no corresponding property on the class file?

Nothing really happens, that property won't be mapped. However, if that JSON key refers to a class (one-to-one relationship) or a an array (one-to-many) you must provide it or the mapping will fail.

#### Can I use Swift optionals?

Yes you can.

#### What data types are supported?

The mapper uses Apple's NSJSONSerialization, so the supported types are the same. Have a look at [NSJSONSerialization's class documentation](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/) for more details.

