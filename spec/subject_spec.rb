# Example RSpec file for subjects (implicit and explicit)
#
# Instructions:
# 1. Run `rspec` to see how `subject` works.
# 2. Try defining your own subjects!

RSpec.describe Array do
  subject { [1,2,3] }

  it 'has length 3' do
    expect(subject.length).to eq(3)
  end
end

RSpec.describe 'Explicit subject' do
  subject(:greeting) { 'hello' }

  it 'is hello' do
    expect(greeting).to eq('hello')
  end
end
