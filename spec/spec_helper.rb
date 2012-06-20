require 'tmpdir'
require 'vimrunner'

Vimrunner::Server.class_eval do
  attr_reader :pid
end

VIM = Vimrunner.start

RSpec.configure do |config|
  config.around do |example|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        VIM.command("cd #{dir}")
        example.call
      end
    end
  end

  config.before(:suite) do
    VIM.add_plugin(File.expand_path('../..', __FILE__), 'plugin/twiddle.vim')
  end

  config.after(:suite) do
    VIM.kill
    Process.kill(6, VIM.server.pid)
  end
end
