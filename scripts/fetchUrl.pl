#!/usr/bin/perl

#
#  This perl script illustrates fetching information from a CGI program
#  that typically gets its data via an HTML form using a POST method.
#
#  Copyright (c) 2014, Carnegie Mellon University.  All Rights Reserved.
#

use LWP::Simple;
use strict;
use warnings;

my $username = $ARGV[0];
my $password = $ARGV[1];
my $fileIn = $ARGV[2];
my $fileOut = $ARGV[3];
my $logtype = $ARGV[4];
my $url = 'http://boston.lti.cs.cmu.edu/classes/11-642/HW/HTS/tes.cgi';

#  Fill in your USERNAME and PASSWORD below.

my $ua = LWP::UserAgent->new();
   $ua->credentials("boston.lti.cs.cmu.edu:80", "HTS", $username, $password);
my $result = $ua->post($url,
		       Content_Type => 'form-data',
		       Content      => [ logtype => $logtype,	# cgi parameter
					 infile => [$fileIn],	# cgi parameter
					 hwid => 'HW4'		# cgi parameter
		       ]);

my $resultStr = $result->as_string;	# Reformat the result as a string
   $resultStr =~ s/<br>/\n/g;		# Replace <br> with \n for clarity

open(my $fh, '>', $fileOut);
print $fh $resultStr;
close $fh;

exit;

