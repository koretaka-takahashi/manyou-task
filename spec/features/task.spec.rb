require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:task2)
    visit new_session_path
    fill_in 'Email', with: 'a@a.com'
    fill_in 'session[password]', with: 'aaaaaa'
    click_button 'ログイン'
  end

  scenario "タスクが作成される" do
    fill_in 'task[name]', with: 'test1'
    fill_in '内容', with: 'test1をやる'
    fill_in '終了期限', with: '2019/07/30'
    select '着手中', from: 'task[status]'
    select '高', from: '優先度'
    click_on '登録する'
    click_on '登録する'
    expect(page).to have_content 'test1をやる'
    expect(page).to have_content '2019-07-30'
    expect(page).to have_content '着手中'
    expect(page).to have_content '高'
  end

  scenario "デフォルト値が正しく入ること" do
    visit new_task_path
    fill_in 'task[name]', with: 'test1'
    click_on '登録する'
    click_on '登録する'
    expect(page).to have_content '作成中…'
    expect(page).to have_content Date.today
  end

  scenario "タスクの詳細が表示される" do
    visit task_path(1)
    expect(page).to have_content "test1をやる"
  end

  feature "タスク一覧画面のテスト" do
    background do
    
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
      click_link '終了期限でソート'
      up_task = all('table tr')[0]
      under_task = all('table tr')[1]
      expect(up_task).to have_content 'test2をやる'
      expect(under_task).to have_content 'test1をやる'
    end

    scenario "タスクを優先度でソートできる" do
      visit tasks_path
      click_link '優先度でソート'
      up_task = all('table tr')[0]
      under_task = all('table tr')[1]
      expect(up_task).to have_content 'test1をやる'
      expect(under_task).to have_content 'test2をやる'
    end

    scenario "タスクを名前であいまい検索できる" do
      visit tasks_path
      fill_in 'タスク', with: '1'
      click_on '検索'
      expect(page).to have_content 'test1'
      expect(page).not_to have_content 'test2'
    end

    scenario "タスクを状態で検索できる" do
      visit tasks_path
      select '未着手', from: '状態'
      click_on '検索'
      expect(page).to have_content 'test'
      expect(page).not_to have_content 'test2'
    end
  end
end
