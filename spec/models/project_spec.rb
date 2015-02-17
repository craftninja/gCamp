require 'spec_helper'

describe 'Project -' do
  it 'Validates presence of Name' do
    project = Project.new
    expect(project.valid?).to be(false)
    project.name = 'some awesome thing'
    expect(project.valid?).to be(true)
  end
end
