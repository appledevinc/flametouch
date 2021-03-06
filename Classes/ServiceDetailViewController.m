//
//  ServiceDetailViewController.m
//  FlameTouch
//
//  Created by Tom Insam on 26/06/2009.
//  Copyright 2009 jerakeen.org. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "NSNetService+FlameExtras.h"
#import "FlameTouchAppDelegate.h"

@implementation ServiceDetailViewController

@synthesize host;
@synthesize service;
@synthesize TXTRecordKeys;
@synthesize TXTRecordValues;
@synthesize externalURL;


-(id)initWithHost:(Host*)hst service:(NSNetService*)srv {
  if ([super initWithStyle:UITableViewStyleGrouped] == nil) return nil;
  
  self.host = hst;
  self.service = srv;
  NSDictionary * TXTRecordDict = [NSNetService dictionaryFromTXTRecordData:[self.service TXTRecordData]];
  self.TXTRecordKeys = [[TXTRecordDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  self.TXTRecordValues = [TXTRecordDict objectsForKeys:self.TXTRecordKeys notFoundMarker:@""];
  [self setupExternalURL];
  
/*
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 100.0)];
  
  // header cell to contain word-wrapped version of full text description
  // of the service. This is here because it's the only place you'll otherwise
  // see the full description, as most of them are quite long.
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 5.0, self.tableView.frame.size.width - 20, 100.0)];
  label.font = [UIFont systemFontOfSize:14.0];
  label.textAlignment = UITextAlignmentLeft;
  label.textColor = [UIColor blackColor];
  label.lineBreakMode = UILineBreakModeWordWrap;
  label.numberOfLines = 0;
  label.backgroundColor = [UIColor clearColor];
  label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
  label.text = self.service.humanReadableType;

  // resize label and header frame to just enclose the text.
  CGSize maximumLabelSize = CGSizeMake(self.tableView.frame.size.width - 20, 1000);
  CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode]; 
  CGRect newFrame = label.frame;
  newFrame.size.height = expectedLabelSize.height;
  label.frame = newFrame;
  header.frame = newFrame;
  
  [header addSubview:label];
  [label release];
  
  self.tableView.tableHeaderView = header;
  [header release];
*/  
  
  self.tableView.delegate = self;

	if (((FlameTouchAppDelegate*)[[UIApplication sharedApplication] delegate]).displayMode == SHOWSERVERS) {
		self.title = self.service.humanReadableType;
	}
	else {
		self.title = self.service.name;
	}
  
  
  
  return self;
}


/*
 Split up table in three parts:
 1. General information in 3 or 4 rows: Host, Port, Type[, Human Readable Type]
 2. If available: Actionable button to open URL for the service
 3. TXT record keys and values
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger result = 1;
	if (self.hasOpenServiceButton) result ++;
  if ([self.TXTRecordKeys count] != 0) result ++;
	return result;
}


- (BOOL) hasOpenServiceButton {
  BOOL result = NO;
  NSURL * URL = self.externalURL;
  if (URL != nil) {
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
      result = YES;
    }
  }
  return result;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger result = 0;
	
	if (section == 0) { // section for general information
		if (self.service.humanReadableTypeIsDistinct) result = 5;
		else result = 4;
  }
	else if (section == 1 && self.hasOpenServiceButton) { // section for URL button
    result = 1;
  }
	else  { // section for TXT record
		result = [self.TXTRecordKeys count];
	}

	return result;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell * cell = nil;
	
  if (indexPath.section == 0) {
		cell = [self standardPropertyCellForRow:indexPath.row];
	} else if (indexPath.section == 1 && self.hasOpenServiceButton) {
		cell = [self actionCellForRow:indexPath.row];
  } else {
		cell =  [self TXTRecordPropertyCellForRow:indexPath.row];  
  }
	
	return cell;
}


-(UITableViewCell *)propertyCellWithLabel:(NSString*) label andValue:(NSString*) value {
  static NSString *CellIdentifier = @"PropertyCell";
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    
		UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 1.0, 90.0, cell.frame.size.height - 3)];
		cellLabel.font = [UIFont boldSystemFontOfSize:14.0];
		cellLabel.textAlignment = UITextAlignmentRight;
		cellLabel.textColor = [UIColor grayColor];
		cellLabel.highlightedTextColor = [UIColor whiteColor];
		cellLabel.tag = 1;
		[cell.contentView addSubview:cellLabel];
		[cellLabel release];
    
		cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(103.0, 1.0, cell.frame.size.width - 133.0, cell.frame.size.height - 3.0)];
		cellLabel.font = [UIFont systemFontOfSize:14.0];
    cellLabel.adjustsFontSizeToFitWidth = YES;
    cellLabel.minimumFontSize = 10.0;
		cellLabel.textAlignment = UITextAlignmentLeft;
		cellLabel.highlightedTextColor = [UIColor whiteColor];
    cellLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		cellLabel.tag = 2;
		[cell.contentView addSubview:cellLabel];
		[cellLabel release];
  }
  
	NSString * myLabel = label;
	NSString * myValue = value;
	if (nil == myLabel) myLabel = @"";
	if (nil == myValue) myValue = @"";
	((UILabel*)[cell viewWithTag:1]).text = myLabel;
	((UILabel*)[cell viewWithTag:2]).text = myValue;
  
  // try to parse the value as an url - if we can, then this cell is
  // clickable. Make it blue. I'd like it underlined as well, but that
  // seems to be lots harder.
	NSURL *url = [NSURL URLWithString:myValue];
  if (url && [url scheme] && [url host] && [[UIApplication sharedApplication] canOpenURL:url]) {
    [ ((UILabel*)[cell viewWithTag:2]) setTextColor:[UIColor blueColor] ];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
  } else {
		[ ((UILabel*)[cell viewWithTag:2]) setTextColor:[UIColor blackColor] ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }

  return cell;
}


-(UITableViewCell*) standardPropertyCellForRow: (int) row {
	NSString *label;
	NSString *value;

	if (row == 0) {
		label = NSLocalizedString(@"Host", @"Service Details: Label for host name");
		value = self.service.hostnamePlus;
	} else if (row == 1) {
		label = NSLocalizedString(@"Name", @"Service Details: Name of the service");
		value = [self.service name];
	} else if (row == 2) {
		label = NSLocalizedString(@"Port", @"Service Details: Label for port number");
		value = [NSString stringWithFormat:@"%i", [self.service port]];
	} else if (row == 3) {
		label = NSLocalizedString(@"Type", @"Service Details: Label for type");
		value = self.service.type;
	} else if (row == 4) {
		label = NSLocalizedString(@"Description", @"Service Details: Label for human readable description");
		value = self.service.humanReadableType;
	} 

	UITableViewCell * cell = [self propertyCellWithLabel: label andValue: value];
	return cell;
}


-(UITableViewCell*) TXTRecordPropertyCellForRow: (int) row {
	NSString * label = [self.TXTRecordKeys objectAtIndex:row];
	NSString * value = [[[NSString alloc] initWithData:[self.TXTRecordValues objectAtIndex:row] encoding:NSUTF8StringEncoding] autorelease];
	
	UITableViewCell * cell = [self propertyCellWithLabel: label andValue: value];
	return cell;
}


-(UITableViewCell *)actionCellForRow:(int)row {
  static NSString *CellIdentifier = @"ActionCell";
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 1.0, cell.frame.size.width - 40, cell.frame.size.height - 3)];
    label.font = [UIFont boldSystemFontOfSize:14.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.tag = 1;
    [cell.contentView addSubview:label];
    [label release];

  }
  ((UILabel*)[cell viewWithTag:1]).text = NSLocalizedString(@"Open Service", @"Label of button to open the relevant service on Service Details page");
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ((self.hasOpenServiceButton && indexPath.section == 2) || (!self.hasOpenServiceButton && indexPath.section == 1)) {
    // Pressed one of the TXT Record cells
    NSString *value = [[[NSString alloc] initWithData:[self.TXTRecordValues objectAtIndex:indexPath.row] encoding:NSUTF8StringEncoding] autorelease];
    NSURL *url = [NSURL URLWithString:value];
    if (url && [url scheme] && [url host]) {
      [[UIApplication sharedApplication] openURL:url];
      return;
    }
  } else if (self.hasOpenServiceButton && indexPath.section == 1) {
    // Pressed the Open Service cell 
    NSLog(@"Opening URL %@", self.externalURL);
    // in a couple of seconds, report if we have no wifi
    [[UIApplication sharedApplication] openURL:self.externalURL];
    return;
  }
  
}


-(void)setupExternalURL {
  NSString * URLString = nil;
  
  if ( [[service type] isEqualToString:@"_urlbookmark._tcp."] ) {
    NSInteger index = [self.TXTRecordKeys indexOfObject:@"URL"];
    if (index != NSNotFound) {
      NSData * URLData = [self.TXTRecordValues objectAtIndex:index];
      URLString = [[[NSString alloc] initWithData:URLData encoding:NSUTF8StringEncoding] autorelease];
    }

  } else if ( [[service type] isEqualToString:@"_http._tcp."] ) {
    if ([service port] == 80) {
      URLString = [NSString stringWithFormat:@"http://%@/", host.ip];
    } else {
      URLString = [NSString stringWithFormat:@"http://%@:%i/", host.ip, [service port]];
    }

  } else if ( [[service type] isEqualToString:@"_ssh._tcp."] ) {
    if ([service port] == 22) {
      URLString = [NSString stringWithFormat:@"ssh://%@/", host.ip];
    } else {
      URLString = [NSString stringWithFormat:@"ssh://%@:%i/", host.ip, [service port]];
    }
  }
  
  NSURL * result = nil;
  if (URLString != nil) {
    result = [NSURL URLWithString:URLString];
  }
  
  self.externalURL = result;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES; 
}


- (void)dealloc {
  self.host = nil;
  self.service = nil;
  self.TXTRecordKeys = nil;
  self.TXTRecordValues = nil;
  self.externalURL = nil;
  [super dealloc];
}


@end
