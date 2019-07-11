require 'rails_helper'

RSpec.describe Task, type: :model do

  it "nameが空だとバリデーションエラーになること" do
    # task = Task.new(name: '', content: 'test1をやる')
    task = FactoryBot.build(:task, name: '')
    expect(task).not_to be_valid
  end  

  it "contentが空だとバリデーションエラーになること" do
    task = FactoryBot.build(:task, content: '')
    expect(task).not_to be_valid
  end

  it "name,contentに値が入っていると保存されること" do
    task = FactoryBot.build(:task, name: 'a', content: 'aa')
    expect(task).to be_valid
  end

  it "contentにデフォルト値が入ること" do
    task = Task.new(name: 'a')
    expect(task.content).to eq '作成中…'
  end

  it "deadlineにデフォルト値が入ること" do
    task = Task.new(name: 'a', deadline: 'Date.today')
    # binding.pry
    expect(task.deadline).to eq Date.today
  end

  it "nameが31文字以上でエラーになること" do
    task = FactoryBot.build(:task, name: 'a' * 31)
    expect(task).not_to be_valid
  end

  it "contentが1001文字以上でエラーになること" do
    task = FactoryBot.build(:task, content: 'a' * 1001)
    expect(task).not_to be_valid
  end
end
