require 'rails_helper'

RSpec.feature "ユーザー機能", type: :feature do

  scenario "ユーザ登録および同時にログインされること" do
    visit new_user_path
    fill_in 'ユーザー名', with: 'a'
    fill_in 'Email', with: 'a@a.com'
    fill_in 'パスワード', with: 'aaaaaa'
    fill_in '確認用パスワード', with: 'aaaaaa'
    click_on '登録する'
    expect(page).to have_content 'aさんのマイページ'
    expect(page).to have_content '登録メールアドレス：a@a.com'
  end  

  feature "ユーザー登録後のテスト" do
    background do
      FactoryBot.create(:user, id: 1)
      FactoryBot.create(:user2, id: 3)
    end  

    scenario " 同じEmailを登録できないこと" do
      visit new_user_path
      fill_in 'ユーザー名', with: 'b'
      fill_in 'Email', with: 'a@a.com'
      fill_in 'パスワード', with: 'bbbbbb'
      fill_in '確認用パスワード', with: 'bbbbbb'
      click_on '登録する'
      expect(page).to have_content 'Emailはすでに存在します'
    end  

    scenario "未ログインで一覧ページに飛ぶとログインページに遷移すること" do
      visit root_path
      expect(page).not_to have_content 'aさんのタスク一覧'
      expect(page).to have_content 'Email'
      expect(page).to have_content 'パスワード'
    end  
    
    feature "ログイン後のテスト" do
      background do
        visit new_session_path
        fill_in 'Email', with: 'a@a.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_button 'ログイン'
      end
  
      scenario "ログインができること" do
        expect(page).to have_content 'aさんのマイページ'
        expect(page).to have_content '登録メールアドレス：a@a.com'
      end  

      scenario "ログアウトができること" do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end  
  
      scenario "自分が作成したタスクだけが表示されること" do
        FactoryBot.create(:task, user_id: 1)
        FactoryBot.create(:task2, user_id: 3)
        click_on '一覧'
        expect(page).to have_content 'test1をやる'
        expect(page).not_to have_content 'test2をやる'
      end  

      scenario "ログイン中はユーザー登録画面に行けないこと" do
        visit new_user_path
        expect(page).to have_content '操作のためにはログアウトが必要です。'
      end  
  
      scenario "ログインユーザー以外のマイページに行けないこと" do
        visit user_path(2)
        expect(page).to have_content '権限がありません。'
      end 

      feature "ユーザー管理機能のテスト" do
        scenario "ユーザー一覧が表示されること" do
          click_on '管理メニュー'
          expect(page).to have_content 'a'
          expect(page).to have_content 'b'
        end  
    
        scenario "ユーザーが作成されること" do
          click_on 'ログアウト'
          click_on '管理メニュー'
          click_link 'ユーザー作成'
          fill_in 'ユーザー名', with: 'c'
          fill_in 'Email', with: 'c@c.com'
          fill_in 'パスワード', with: 'cccccc'
          fill_in '確認用パスワード', with: 'cccccc'
          click_on '登録する'
          expect(page).to have_content 'cさんのマイページ'
          expect(page).to have_content 'c@c.com'
        end  
    
        scenario "ユーザーが更新されること" do
          user = FactoryBot.create(:user3, id: 2)
          visit edit_admin_user_path(user.id)
          fill_in 'ユーザー名', with: 'c'
          fill_in 'Email', with: 'd@d.com'
          fill_in 'パスワード', with: 'cccccc'
          fill_in '確認用パスワード', with: 'cccccc'
          click_on '更新する'
          expect(page).to have_content 'cさんのマイページ'
          expect(page).to have_content 'd@d.com'
        end  
    
        scenario "ユーザーが削除されること" do
          visit admin_user_path(3)
          click_link 'ユーザー情報を削除する'
          expect(page).to have_content 'ユーザー情報を削除しました。'
        end  
      end
    end   
  end 
end  
