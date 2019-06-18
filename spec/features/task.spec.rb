require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク一覧のテスト" do
    Task.create!(name: 'test1', content: 'test1をやる')
    Task.create!(name: 'test2', content: 'test2をやる')

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'test1をやる'
    expect(page).to have_content 'test2をやる'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'タスク', with: 'test1'
    fill_in '内容', with: 'test1をやる'
    click_on '登録する'
    expect(page).to have_content 'test1をやる'

    # expect {
    #   visit new_task_path
    #   fill_in 'タスク', with: 'test1'
    #   fill_in '内容', with: 'test1をやる'
    #   click_on '登録する'
    # }.to change(Task, :count).by(1)
  end

  scenario "タスク詳細のテスト" do
    test_task = Task.create!(name: 'test1', content: 'test1をやる')
    visit task_path(test_task.id)
    expect(page).to have_content "test1をやる"
  end
end
