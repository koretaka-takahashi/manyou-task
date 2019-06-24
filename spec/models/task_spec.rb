require 'rails_helper'

RSpec.describe Task, type: :model do

  it "nameが空だとバリデーションエラーになること" do
    task = Task.new(name: '', content: 'test1をやる')
    expect(task).to be_valid
  end  

  it "contentが空だとバリデーションエラーになること" do
  end  

  it "name,contentに値が入っていると保存されること" do
  end

  it "contentにデフォルトの値が入っていること" do
  end

end
