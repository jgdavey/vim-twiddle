require 'spec_helper'

describe 'twiddle.vim' do
  let(:file) { "mine.rb" }

  before do
    File.open(file, 'w+') { |f| f.write contents }
    VIM.edit file
  end

  context "with two arguments" do
    let(:contents) do
      <<-EOS.gsub(/^ {8}/, '')
        def something(arg1, arg2)
          puts arg1
        end
      EOS
    end

    it "switches the order of them" do
      VIM.search "arg1"
      VIM.command "call TwiddleArguments()<CR>"
      VIM.write
      File.open(file).readlines[0].chomp.should == "def something(arg2, arg1)"
    end
  end

  context "with three arguments, on the first one" do
    let(:contents) do
      <<-EOS.gsub(/^ {8}/, '')
        def something(arg1, arg2, arg3)
          puts arg1
        end
      EOS
    end

    it "switches the order of the first two" do
      VIM.search "arg1"
      VIM.command "call TwiddleArguments()<CR>"
      VIM.write
      File.open(file).readlines[0].chomp.should == "def something(arg2, arg1, arg3)"
    end
  end

  context "with three arguments, on the second one" do
    let(:contents) do
      <<-EOS.gsub(/^ {8}/, '')
        def something(arg1, arg2, arg3)
          puts arg1
        end
      EOS
    end

    it "switches the order of the first two" do
      VIM.search "arg2"
      VIM.command "call TwiddleArguments()<CR>"
      VIM.write
      File.open(file).readlines[0].chomp.should == "def something(arg1, arg3, arg2)"
    end
  end

  context "with three arguments, on the last one" do
    let(:contents) do
      <<-EOS.gsub(/^ {8}/, '')
        def something(arg1, arg2, arg3)
          puts arg1
        end
      EOS
    end

    it "does nothing" do
      VIM.search "arg3"
      VIM.command "call TwiddleArguments()<CR>"
      VIM.write
      File.open(file).readlines[0].chomp.should == "def something(arg1, arg2, arg3)"
    end
  end
end
