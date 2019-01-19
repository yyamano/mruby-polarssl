#!/usr/bin/env ruby
#
# mrbgems test runner
#

if __FILE__ == $0
  repository, dir = 'https://github.com/mruby/mruby.git', 'tmp/mruby'
  build_args = ARGV

  Dir.mkdir 'tmp'  unless File.exist?('tmp')
  unless File.exist?(dir)
    system "git clone #{repository} --branch 1.3.0 #{dir}"
  end

  exit system(%Q[cd #{dir}; MRUBY_CONFIG=#{File.expand_path __FILE__} ruby minirake #{build_args.join(' ')}])
end

MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'

  conf.gem :git => 'git@github.com:iij/mruby-io.git'
  conf.gem :git => 'git@github.com:iij/mruby-pack.git'
  conf.gem :git => 'git@github.com:iij/mruby-socket.git'
  conf.gem :git => 'git@github.com:iij/mruby-mtest.git'

  conf.gem File.expand_path(File.dirname(__FILE__))
  conf.enable_test
end
