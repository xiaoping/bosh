require 'spec_helper'

describe Bosh::Cli::Runner do

  before(:all) do
    Bosh::Cli::Runner.class_eval do
      def cmd_dummy_cmd(arg1, arg2, arg3); end
    end
  end

  it "dispatches commands to appropriate methods" do
    runner = Bosh::Cli::Runner.new(:dummy_cmd, $stdout, 1, 2, 3)
    runner.should_receive(:cmd_dummy_cmd).with(1, 2, 3)
    runner.run
  end

  it "whines on invalid arity" do
    runner = Bosh::Cli::Runner.new(:dummy_cmd, $stdout, 1, 2)

    lambda {
      runner.run
    }.should raise_error(ArgumentError, "wrong number of arguments for Bosh::Cli::Runner#cmd_dummy_cmd (2 for 3)")
  end

  it "whines on invalid command" do
    runner = Bosh::Cli::Runner.new(:do_stuff, $stdout, 1, 2)

    lambda {
      runner.run
    }.should raise_error(Bosh::Cli::UnknownCommand, "unknown command 'do_stuff'")
  end
  
end