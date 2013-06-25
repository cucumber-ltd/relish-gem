require 'relish/commands/handle'

module Relish
  module Commands
    describe Handle do
      context "converting to resource URL" do
        context "with publisher and project id" do
          handle = Handle.new('foo/bar')
          it "converts to a URL with a querystring parameter" do
            handle.resource_url.should == "projects/bar?publisher_id=foo"
          end
        end

        context "with project id only" do
          handle = Handle.new('bar')
          it "converts to one querystring parameter" do
            handle.resource_url.should == "projects/bar"
          end
        end
      end
    end
  end
end
