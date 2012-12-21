//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "SKNSStringAdditions.h"

#import <CommonCrypto/CommonDigest.h>

#import "ASIDataDecompressor.h"
#import "pinyin.h"

@implementation NSString (SKNSStringAdditions)

+ (NSString *)dateString
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
	return [formatter stringFromDate:[NSDate date]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
  NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  for (NSInteger i = 0; i < self.length; ++i) {
    unichar c = [self characterAtIndex:i];
    if (![whitespace characterIsMember:c]) {
      return NO;
    }
  }
  return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding {
  NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
  NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
  NSScanner* scanner = [[[NSScanner alloc] initWithString:self] autorelease];
  while (![scanner isAtEnd]) {
    NSString* pairString = nil;
    [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
    [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
    NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
    if (kvPair.count == 1 || kvPair.count == 2) {
      NSString* key = [[kvPair objectAtIndex:0]
                       stringByReplacingPercentEscapesUsingEncoding:encoding];
      NSMutableArray* values = [pairs objectForKey:key];
      if (nil == values) {
        values = [NSMutableArray array];
        [pairs setObject:values forKey:key];
      }
      if (kvPair.count == 1) {
        [values addObject:[NSNull null]];

      } else if (kvPair.count == 2) {
        NSString* value = [[kvPair objectAtIndex:1]
                           stringByReplacingPercentEscapesUsingEncoding:encoding];
        [values addObject:value];
      }
    }
  }
  return [NSDictionary dictionaryWithDictionary:pairs];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
  NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        //add start caiguo
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        value = [value stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
        //add end  //http://www.w3schools.com/tags/ref_urlencode.asp
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }

  NSString* params = [pairs componentsJoinedByString:@"&"];
  if ([self rangeOfString:@"?"].location == NSNotFound) {
    return [self stringByAppendingFormat:@"?%@", params];

  } else {
    return [self stringByAppendingFormat:@"&%@", params];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSComparisonResult)versionStringCompare:(NSString *)other {
  NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
  NSArray *twoComponents = [other componentsSeparatedByString:@"a"];

  // The parts before the "a"
  NSString *oneMain = [oneComponents objectAtIndex:0];
  NSString *twoMain = [twoComponents objectAtIndex:0];

  // If main parts are different, return that result, regardless of alpha part
  NSComparisonResult mainDiff;
  if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
    return mainDiff;
  }

  // At this point the main parts are the same; just deal with alpha stuff
  // If one has an alpha part and the other doesn't, the one without is newer
  if ([oneComponents count] < [twoComponents count]) {
    return NSOrderedDescending;

  } else if ([oneComponents count] > [twoComponents count]) {
    return NSOrderedAscending;

  } else if ([oneComponents count] == 1) {
    // Neither has an alpha part, and we know the main parts are the same
    return NSOrderedSame;
  }

  // At this point the main parts are the same and both have alpha parts. Compare the alpha parts
  // numerically. If it's not a valid number (including empty string) it's treated as zero.
  NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
  NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
  return [oneAlpha compare:twoAlpha];
}

- (NSString *)parseWithPattern:(NSString *)pattern
{
    NSRange range = [self rangeOfString:[NSString stringWithFormat:@"[%@]",pattern]];
    NSRange endRange = [self rangeOfString:[NSString stringWithFormat:@"[/%@]",pattern]];
	if (range.length > 0 && endRange.length > 0 )
	{
		NSInteger startIndex = range.location;
		NSInteger length = endRange.location;
		NSRange subStringRange = NSMakeRange(startIndex + pattern.length + 2, length - startIndex - pattern.length - 2);
		return [self substringWithRange:subStringRange];
	}
	return nil;
}

- (NSString *)deleteWithPattern:(NSString *)pattern
{
    NSRange range = [self rangeOfString:[NSString stringWithFormat:@"[%@]",pattern]];
    NSRange endRange = [self rangeOfString:[NSString stringWithFormat:@"[/%@]",pattern]];
	if (range.length > 0 && endRange.length > 0 )
	{
        NSRange subStringRange = NSMakeRange(range.location, endRange.location+endRange.length);
        NSMutableString *mutableCopy = [[self mutableCopy] autorelease];
        [mutableCopy replaceCharactersInRange:subStringRange withString:@""];
        return [[mutableCopy copy] autorelease];
	}
	return self;
}

- (NSString *)stringByDecodingURLFormat
{
    self = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    self = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return self;
}

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)formattedPhoneNumber
{
    if([self length] < 1)
		return nil;
	NSString* telNumber = @"";
    NSArray *numArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
	for (int i=0; i<[self length]; i++) {
		NSString* chr = [self substringWithRange:NSMakeRange(i, 1)];
		if([numArray containsObject:chr]) {
			telNumber = [telNumber stringByAppendingFormat:@"%@", chr];
		}
	}
    if ([telNumber length] == 13 && [telNumber hasPrefix:@"86"]) {
        telNumber = [telNumber substringWithRange:NSMakeRange(2,11)];
        return telNumber;
    }
    if ([telNumber length] != 11 || ![telNumber hasPrefix:@"1"]) {
        return nil;
    }
	return telNumber;
}

+ (NSString *)MapImageUrlWithLatitude:(double )latitude Longitude:(double )longitude MapWidth:(int )mapWidth MapHeight:(int )mapHeight
{
    NSString *mapUrl = @"http://maps.google.com/maps/api/staticmap";
    NSString *zoom = @"15";
    NSString *sensor = @"false";
    NSString *center = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    NSString *markers = [NSString stringWithFormat:@"color:red|label:S|%f,%f",latitude,longitude];
    NSString *size = [NSString stringWithFormat:@"%dx%d",mapWidth,mapHeight];
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:center,@"center",zoom,@"zoom",markers,@"markers",size,@"size",sensor,@"sensor", nil];
    NSString* fullURL = [mapUrl stringByAddingQueryDictionary:paramDict];
    return fullURL;
}

+ (NSString *)stringFromFileSize:(int)theSize
{
    float floatSize = theSize;
	if (theSize<1023)
		return([NSString stringWithFormat:@"%i bytes",theSize]);
	floatSize = floatSize / 1024;
	if (floatSize<1023)
		return([NSString stringWithFormat:@"%1.1f KB",floatSize]);
	floatSize = floatSize / 1024;
	if (floatSize<1023)
		return([NSString stringWithFormat:@"%1.1f MB",floatSize]);
	floatSize = floatSize / 1024;
    
	return([NSString stringWithFormat:@"%1.1f GB",floatSize]);
}

+ (NSString *)formattedDateRelativeToNow:(NSDate *)date;
{
    NSDateFormatter *midNightDF = [[[NSDateFormatter alloc] init] autorelease];
    [midNightDF setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *resultDF = [[[NSDateFormatter alloc] init] autorelease];
    
    NSDate *midnight = [midNightDF dateFromString:[midNightDF stringFromDate:date]];
	
    NSInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);
	NSInteger sencondDiff = (int)[date timeIntervalSinceNow];
    
	if (dayDiff == 0 ) {
        if (-sencondDiff < 0) {
            return @"0秒前";
        }
        if(-sencondDiff < 60){
            return [NSString stringWithFormat:@"%i秒前",-sencondDiff];
        }
        else if(-sencondDiff < 60*60){
            return [NSString stringWithFormat:@"%i分钟前",-sencondDiff/60];
        }
        else if(60*60 <= -sencondDiff < 60*60*24){
            return [NSString stringWithFormat:@"%i小时前",-sencondDiff/60/60];
        }
    }
    else if(dayDiff == -1){
        [resultDF setDateFormat:@"'昨天 'a h':'mm"];
    }
    
	else if(dayDiff == -2){
		[resultDF setDateFormat:@"'前天 'a h':'mm"];
    }
	else
	{
        [resultDF setDateFormat:@"MM-dd a h':'mm"];
	}
    
	return [resultDF stringFromDate:date];
}

- (int )getFileType
{
    typedef enum{
        MM_FILETYPE_DOC = 1,    //.doc
        MM_FILETYPE_PPT,        //.ppt
        MM_FILETYPE_XLS,        //.xls
        MM_FILETYPE_KEY,        //.key
        MM_FILETYPE_NUMBERS,    //.numbers
        MM_FILETYPE_PAGES,      //.pages
        MM_FILETYPE_PDF,        //.pdf
        MM_FILETYPE_RTF,        //.rtf
        MM_FILETYPE_TXT,        //.txt
        MM_FILETYPE_OTHER
    }MM_FILETYPE;
    
    if ([[self componentsSeparatedByString:@";"] count] != 3) {
        return MM_FILETYPE_OTHER;
    }
    NSString *fileName = [[self componentsSeparatedByString:@";"] objectAtIndex:1];
    if ([[fileName componentsSeparatedByString:@"."] count] < 2) {
        return MM_FILETYPE_OTHER;
    }
    NSString *pathExtension = [[[fileName componentsSeparatedByString:@"."] objectAtIndex:[[fileName componentsSeparatedByString:@"."] count] - 1] lowercaseString];
    if ([pathExtension isEqualToString:@"doc"]||[pathExtension isEqualToString:@"docx"]) {
        return MM_FILETYPE_DOC;
    }
    else if ([pathExtension isEqualToString:@"ppt"]||[pathExtension isEqualToString:@"pptx"]) {
        return MM_FILETYPE_PPT;
    }
    else if ([pathExtension isEqualToString:@"xls"]||[pathExtension isEqualToString:@"xlsx"]) {
        return MM_FILETYPE_XLS;
    }
    else if ([pathExtension isEqualToString:@"key"]) {
        return MM_FILETYPE_KEY;
    }
    else if ([pathExtension isEqualToString:@"numbers"]) {
        return MM_FILETYPE_NUMBERS;
    }
    else if ([pathExtension isEqualToString:@"pages"]) {
        return MM_FILETYPE_PAGES;
    }
	else if ([pathExtension isEqualToString:@"pdf"]) {
        return MM_FILETYPE_PDF;
    }
    else if ([pathExtension isEqualToString:@"rtf"]) {
        return MM_FILETYPE_RTF;
    }
    else if ([pathExtension isEqualToString:@"txt"]) {
        return MM_FILETYPE_TXT;
    }
    else{
        return MM_FILETYPE_OTHER;
    }
}



- (NSString *)convertToPinyin
{
    NSMutableString *namePinyin = [NSMutableString string];
    for (int i = 0; i < [self length]; i++)
    { 
        
        if ([[self substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "]) {
            continue;
        }
        
        char tmppinyin = pinyinFirstLetter([self characterAtIndex:i]);
        if (tmppinyin=='Z'+1) {
            unsigned short tempChar = [self characterAtIndex:i];
            //if ((tempChar>='a'&&tempChar<='z') || (tempChar>='A' && tempChar<='Z')) {
                tmppinyin = tempChar;
            //}
        }
//        if (tmppinyin>='a' && tmppinyin<='z') {
//            tmppinyin = tmppinyin-'a'+'A';
//        }
        [namePinyin appendString:[NSString stringWithFormat:@"%c", tmppinyin]];
    }
    if ([namePinyin length]) {
        return namePinyin;
    }else{
        return self;
    }
}

- (BOOL)isAllNumber;
{
    NSArray *numArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    for (int i=0; i<[self length]; i++) {
		NSString* chr = [self substringWithRange:NSMakeRange(i, 1)];
		if(![numArray containsObject:chr]) {
            return NO;
		}
	}
    return YES;
}

@end
