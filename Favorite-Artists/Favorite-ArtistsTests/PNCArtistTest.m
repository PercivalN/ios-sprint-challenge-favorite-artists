//
//  PNCArtistTest.m
//  Favorite Artist3
//
//  Created by Lambda_School_Loaner_263 on 1/28/20.
//  Copyright © 2020 Lamdba School. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PNCFileHelper.h"
#import "PNCArtist.h"
#import "PNCArtist+NSJSONSerialization.h"
#import "PNCArtistController.h"

@interface PNCArtistTest : XCTestCase

@end

@implementation PNCArtistTest

- (void)testParseArtistJson {
    NSBundle *bundle  = [NSBundle bundleForClass:[self class]];
    NSData *data = loadFile(@"Artist.json", bundle);
    XCTAssertNotNil(data);

    NSError *error = nil;

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"Error: %@", error);
    NSLog(@"JSON: %@", json);

    PNCArtist *artist = [[PNCArtist alloc] initWithDictionary:json];



    XCTAssertEqualObjects(@"Macklemore", artist.name);
    XCTAssertEqual(1999, artist.year);
}

- (void)testSaveAndLoadArtists {
    NSBundle *bundle  = [NSBundle bundleForClass:[self class]];
    NSData *data = loadFile(@"Artist.json", bundle);
    XCTAssertNotNil(data);

    NSError *error = nil;

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"Error: %@", error);
    NSLog(@"JSON: %@", json);
    PNCArtistController *controller = [[PNCArtistController alloc] init];
    PNCArtist *artist = [[PNCArtist alloc] initWithDictionary:json];
    XCTAssertEqualObjects(@"Macklemore", artist.name);
    XCTAssertEqual(1999, artist.year);

    [controller addArtist:artist];
    PNCArtist *artist1 = [controller.artists firstObject];
    XCTAssertEqualObjects(@"Macklemore", artist1.name);

    [controller.artists removeAllObjects];
    XCTAssertTrue([controller.artists count] == 0);
    [controller loadArtists];
    PNCArtist *artist2 = [controller.artists firstObject];
    XCTAssertEqualObjects(@"Macklemore", artist2.name);
}

@end
