require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスクが作成される" do
    visit new_task_path
    fill_in 'タスク', with: 'test1'
    fill_in '内容', with: 'test1をやる'
    click_on '登録する'
    expect(page).to have_content 'test1をやる'
  end

  scenario "タスクの詳細が表示される" do
    test_task = Task.create!(name: 'test1', content: 'test1をやる')
    visit task_path(test_task.id)
    expect(page).to have_content "test1をやる"
  end

  feature "タスク一覧画面のテスト" do
    background do
      FactoryBot.create(:task, id: 1, updated_at: Time.current + 1.days)
      FactoryBot.create(:task2, id: 2, updated_at: Time.current + 2.days)
    end

    scenario "タスク一覧が表示される" do
      visit tasks_path
      expect(page).to have_content 'test1をやる'
      expect(page).to have_content 'test2をやる'
    end

    scenario "タスク一覧が作成日時により並び替えられる" do
      visit tasks_path
      up_task = all('table tr')[0]
      under_task = all('table tr')[1]
      expect(up_task).to have_content 'test2をやる'
      expect(under_task).to have_content 'test1をやる'
      # expect(Task.order(created_at: "DESC").map(&:id)).to eq [2, 1]
    end
  end
end
