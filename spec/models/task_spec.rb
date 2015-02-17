require 'spec_helper'

describe 'Task -' do
  it 'Validates presence of Description' do
    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'some awesome thing'
    expect(task.valid?).to be(true)
  end
end
