/*
 * WordCounter.m
 *
 * Created by Oguzhan Cansin Gungor on 15/04/13.
 *
 * Copyright (c) 2013 Aslan-Apps. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *       This product includes software developed by Aslan-Apps.
 * 4. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior written
 *    permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "WordCounter.h"
#include <stdio.h>

@implementation WordCounter

- initWithString: (NSString *) text
{
	if (!(self = [self init]))		
		return nil;

	content = text;				
	
	return self;
}



- count						
{
	nChars = (int)[content length];		

	NSScanner *reader = [NSScanner scannerWithString: content];
	
	if (reader == nil) return nil;		// no content?
	
	// only skip white space characters (not new lines)
	[reader setCharactersToBeSkipped:
		[NSCharacterSet whitespaceCharacterSet]];

	while (![reader isAtEnd])
	{
		NSString *line;			

		[reader scanUpToString: @"\n" intoString: &line];
		nLines++;
		
		NSScanner *lineScanner = [NSScanner scannerWithString: line];

		if (lineScanner == nil) return nil;

		while (![lineScanner isAtEnd])
		{
			if ([lineScanner scanUpToCharactersFromSet:
			     [NSCharacterSet whitespaceAndNewlineCharacterSet]
							intoString: NULL])
				nWords++;
		}

		// skip the new line character
		[reader scanString: @"\n" intoString: NULL];
	}
	
	return self;
}


- (int) lines
{
	return nLines;
}


- (int) words
{
	return nWords;
}

- (int) characters
{
	return nChars;
}
@end
