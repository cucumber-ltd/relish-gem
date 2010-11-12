shared_examples_for 'a Dsl that utilizes ContextClass' do

  describe '#context_class_eval' do
    let(:context_class) { Class.new }
    let(:base) { described_class.new(context_class) }
    let(:the_block) { Proc.new { "Hi, I'm a block" } }
  
    it 'calls class_eval on the context_class with the given block' do
      context_class.should_receive(:class_eval).with(&the_block)
      base.context_class_eval(&the_block)
    end
  end

  describe '#context_class_name' do
    let(:context_class) { Class.new }
    let(:base) { described_class.new(context_class) }
    before { context_class.should_receive(:name).and_return('::Dog') }
  
    it 'returns the class name downcased' do
      base.context_class_name.should eq('dog')
    end
  end

end