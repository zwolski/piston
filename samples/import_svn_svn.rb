#!/usr/bin/env ruby
#
# Import an SVN repository into an SVN working copy.
require File.dirname(__FILE__) + "/common"

(@root + "tmp/repos").rmtree rescue nil
(@root + "tmp/wc").rmtree rescue nil
(@root + "tmp/.xlsuite.tmp").rmtree rescue nil

svnadmin :create, @root + "tmp/repos"
svn :checkout, "file://#{(@root + 'tmp/repos').realpath}", @root + "tmp/wc"

repos = Piston::Svn::Repository.new("http://svn.xlsuite.org/trunk/lib")
rev = repos.at(:head)
rev.checkout_to(@root + "tmp/.xlsuite.tmp")
wc = Piston::Svn::WorkingCopy.new(@root + "tmp/wc/vendor")
wc.create
wc.copy_from(rev)
wc.remember(rev.remember_values)
wc.finalize
