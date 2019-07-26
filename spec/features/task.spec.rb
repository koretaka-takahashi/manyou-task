require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスクが作成される" do
    visit new_task_path
    fill_in 'タスク', with: 'test1'
    fill_in '内容', with: 'test1をやる'
    fill_in '終了期限', with: '2019/7/30'
    click_on '登録する'
    expect(page).to have_content 'test1をやる'
  end

  scenario "デフォルト値が正しく入ること" do
    visit new_task_path
    fill_in 'タスク', with: 'test1'
    click_on '登録する'
    click_on '登録する'
    expect(page).to have_content '作成中…'
    expect(page).to have_content Date.today
  end

  scenario "タスクの詳細が表示される" do
    test_task = Task.create!(name: 'test1', content: 'test1をやる')
    visit task_path(test_task.id)
    expect(page).to have_content "test1をやる"
  end

  feature "タスク一覧画面のテスト" do
    background do
      FactoryBot.create(:task, id: 1, updated_at: Time.current + 1.days, deadline: Time.current + 2.days)
      FactoryBot.create(:task2, id: 2, updated_at: Time.current + 2.days, deadline: Time.current + 1.days)
    end

    scenario "タスク一覧が表示される" do
      visit tasks_path
      expect(page).to have_content 'test1をやる'
      expect(page).to have_content 'test2をやる'
    end

    scenario "タスク一覧が作成日時でソートされている" do
      visit tasks_path
      up_task = all('table tr')[0]
      under_task = all('table tr')[1]
      expect(up_task).to have_content 'test2をやる'
      expect(under_task).to have_content 'test1をやる'
      # expect(Task.order(created_at: "DESC").map(&:id)).to eq [2, 1]
    end

    scenario "タスクを終了期限でソートできる" do
      visit tasks_path
      click_on '終了期限でソート'
      up_task = all('table tr')[0]
      under_task = all('table tr')[1]
      expect(up_task).to have_content 'test2をやる'
      expect(under_task).to have_content 'test1をやる'
    end
  end
end
