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

  it "contentにデフォルト値が入ること" do  # モデルでやってる事じゃ無いので要らないかも
    task = Task.new(name: 'a')
    expect(task.content).to eq '作成中…'
  end

  it "deadlineにデフォルト値が入ること" do  # モデルでやってる事じゃ無いので要らないかも
    Task.create(name: 'a')
    task = Task.find(1)
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

  # it "deadlineでソートされること" do
  #   task = FactoryBot.build(:task, name: '')
  # end  

  # it "created_atでソートされること" do
  #   task = FactoryBot.build(:task, name: '')
  # end  
  
  describe "検索のテスト" do
    it "nameであいまい検索されること" do
      task = FactoryBot.create(:task, name: '-a-')
      task2 = FactoryBot.create(:task2)
      task3 = FactoryBot.create(:task3)
      result = Task.search_by_name(task: {name: 'a'})
      expect(result[0]).to eq task
      expect(result.size).to be 1
    end  

    it "statusで検索されること" do
      task = FactoryBot.create(:task, status: 2)
      task2 = FactoryBot.create(:task2)
      task3 = FactoryBot.create(:task3)
      result = Task.search_by_status(task: {status: 2})
      expect(result[0]).to eq task
      expect(result.size).to be 1
    end  
  end
end
