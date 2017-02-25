require_relative '../acceptance_helper'

feature 'Add files to question', %q{

  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  use_selenium_webdriver!

  given(:user) { create(:user) }

  background do
    login_as(user, scope: :user, run_callbacks: false)
    visit new_question_path
  end

  scenario 'User adds file when asks question', js: true do
    fill_in t('activerecord.attributes.question.title'), with: 'Test question'
    page.execute_script("$('.wysihtml5-sandbox')[0].contentWindow.document.body.innerHTML='Test body';")

    inputs = all('.select-file')
    inputs[0].set("#{Rails.root}/spec/support/test_file.dat")

    click_on t('common.button.create')

    expect(page).to have_link 'test_file.dat'
  end

  scenario 'User adds some files when asks question', js: true do
    fill_in t('activerecord.attributes.question.title'), with: 'Test question'
    page.execute_script("$('.wysihtml5-sandbox')[0].contentWindow.document.body.innerHTML='Test body';")

    click_on t('common.button.attachment.add')

    inputs = all('.select-file')
    inputs[0].set("#{Rails.root}/spec/support/test_file.dat")
    inputs[1].set("#{Rails.root}/spec/support/test_file.dat")

    click_on t('common.button.create')

    expect(page).to have_link 'test_file.dat', href: '/uploads/attachment/file/1/test_file.dat'
    expect(page).to have_link 'test_file.dat', href: '/uploads/attachment/file/2/test_file.dat'
  end

end