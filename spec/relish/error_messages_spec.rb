require 'spec_helper'

module Relish
  describe ErrorMessages do
    
    describe '#project_blank' do
      specify do
        described_class.project_blank.should eq(
          "Please specify a project. Run 'relish help' for usage information."
        )
      end
    end
  
    describe '#unknown_command' do
      specify do
        described_class.unknown_command.should eq(
          "Unknown command. Run 'relish help' for usage information."
        )
      end
    end
    
  end
end