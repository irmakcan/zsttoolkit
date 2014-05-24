//
//  ZSTStringValidationsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSString+ZSTValidations.h"


SPEC_BEGIN(ZSTStringValidationsSpec)

describe(@"ZSTStringValidations", ^{
  
  describe(@"email", ^{
    describe(@"valid email addresses", ^{
      it(@"should return YES for valid email addresses", ^{
        NSArray *validEmailAddresses = @[
                                         @"email@example.com",
                                         @"firstname.lastname@example.com",
                                         @"email@subdomain.example.com",
                                         @"firstname+lastname@example.com",
                                         @"email@123.123.123.123",
                                         @"email@[123.123.123.123]",
                                         @"\"email\"@example.com",
                                         @"1234567890@example.com",
                                         @"email@example-one.com",
                                         @"_______@example.com",
                                         @"email@example.name",
                                         @"email@example.museum",
                                         @"email@example.co.jp",
                                         @"email@example.com.tr",
                                         @"firstname-lastname@example.com"
                                         ];
        for (NSString *email in validEmailAddresses) {
          BOOL isValid = [email zst_isValidEmailAdress];
          if (!isValid) {
            NSLog(@"\nValid email failed validation: %@\n", email);
          }
          [[theValue(isValid) should] beYes];
        }
      });
      
      it(@"should return YES for stranger valid email addresses", ^{
        // Copied from wikipedia, not all valid addresses included
        NSArray *validEmailAddresses = @[
                                         @"niceandsimple@example.com",
                                         @"very.common@example.com",
                                         @"a.little.lengthy.but.fine@dept.example.com",
                                         @"disposable.style.email.with+symbol@example.com",
                                         @"other.email-with-dash@example.com",
                                         @"\"very.unusual.@.unusual.com\"@example.com",
                                         @"!#$%&'*+-/=?^_`{}|~@example.org"
                                         ];
        for (NSString *email in validEmailAddresses) {
          BOOL isValid = [email zst_isValidEmailAdress];
          if (!isValid) {
            NSLog(@"\nValid email failed validation: %@\n", email);
          }
          [[theValue(isValid) should] beYes];
        }
      });
    });
    describe(@"invalid email addresses", ^{
      it(@"should return NO for invalid email addresses", ^{
        NSArray *invalidEmailAddresses = @[
                                           @"plainaddress",
                                           @"#@%^%#$@#$@#.com",
                                           @"@example.com",
                                           @"Joe Smith <email@example.com>",
                                           @"email.example.com",
                                           @"email@example@example.com",
                                           @".email@example.com",
                                           @"email.@example.com",
                                           @"email..email@example.com",
                                           @"あいうえお@example.com",
                                           @"email@example.com (Joe Smith)",
                                           @"email@example",
                                           @"email@-example.com",
                                           @"email@example..com",
                                           @"Abc..123@example.com"
                                         ];
        for (NSString *email in invalidEmailAddresses) {
          BOOL isValid = [email zst_isValidEmailAdress];
          if (isValid) {
            NSLog(@"\nInvalid email pass validation: %@\n", email);
          }
          [[theValue(isValid) should] beNo];
        }
      });
      
      it(@"should return NO for strange invalid email addresses", ^{
        // Copied from wikipedia
        NSArray *invalidEmailAddresses = @[
                                           @"Abc.example.com",
                                           @"A@b@c@example.com",
                                           @"a\"b(c)d,e:f;g<h>i[j\\k]l@example.com",
                                           @"just\"not\"right@example.com",
                                           @"this is\"not\allowed@example.com",
                                           @"this\\ still\"not\\allowed@example.com"
                                           ];
        for (NSString *email in invalidEmailAddresses) {
          BOOL isValid = [email zst_isValidEmailAdress];
          if (isValid) {
            NSLog(@"\nInvalid email pass validation: %@\n", email);
          }
          [[theValue(isValid) should] beNo];
        }
      });
    });
  });
  
});

SPEC_END
