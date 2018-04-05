require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'Sign in/ Sign up |' do



    let!(:email) { 'admin@onlinestore-tamlhacv.herokuapp.com' }
    let!(:password) { 'onlinestore-tamlhacv.herokuapp.com' }
    let!(:random) { rand(100) }
    let!(:random_email) { random.to_s + email }
    let!(:user) { create(:user, email: random_email, password: password) }

    def logOut(path)
      visit path
      first(:link, 'Log out').click
    end
    def userAction(path, type)
      visit path
      case type
      when 'SignUp'
        first(:link, 'Sign in').click
        first(:link, 'Sign up').click
      when 'SignIn'
        first(:link, 'Sign in').click
      when 'ForgotPassword'
        first(:link, 'Sign in').click
        first(:link, 'Forgot your password?').click
      end
    end
    def fillIn(type, email, password = '', confirm_password = '')
      case type
        when 'SignUp'
          fill_in 'Email', with: email
          fill_in 'Password', with: password
          fill_in 'Password confirmation', with: confirm_password
          click_on('Sign up')
        when 'SignIn'
          fill_in 'Email', with: email
          fill_in 'Password', with: password
          click_on('Log in')
        when 'ForgotPassword'
          fill_in 'Email', with: email
          click_on('Send me reset password instructions')
      end
    end
    context 'Sign up' do
      it "sucessfull" do
        userAction(root_path, 'SignUp')
        fillIn('SignUp', email, password, password)
        expect(page).to have_content('Welcome! You have signed up successfully.')
      end
      context "failure" do
        it "nil infomation" do
          userAction(root_path, 'SignUp')
          fillIn('SignUp','','','')
          expect(page).not_to have_content('Welcome! You have signed up successfully.')
          expect(page).to have_content('2 errors prohibited this user from being saved')
          expect(page).to have_content('Email can\'t be blank')
          expect(page).to have_content('Password can\'t be blank')
        end
        it "email" do
          userAction(root_path, 'SignUp')
          fillIn('SignUp', 'wrong_email', password, password)
          expect(page).to have_content('Email is invalid Email')
        end
        it "password null" do
          userAction(root_path, 'SignUp')
          fillIn('SignUp', email, '', '')
          expect(page).to have_content('Password can\'t be blank')
        end
        it "password short" do
          userAction(root_path, 'SignUp')
          fillIn('SignUp', email, '123', '123')
          expect(page).to have_content('Password is too short (minimum is 6 characters)')
        end
        it "password confirm different password" do
          userAction(root_path, 'SignUp')
          fillIn('SignUp', email, password, '2')
          expect(page).to have_content('Password confirmation doesn\'t match Password')
        end
      end
    end
    context 'Sign in' do
      it "sucessfull" do
        userAction(root_path, 'SignIn')
        fillIn('SignIn', user.email, user.password)
        expect(page).to have_content('Signed in successfully.')
      end
      it "failure" do
        userAction(root_path, 'SignIn')
        fillIn('SignIn', 'wrong_email', user.password)
        expect(page).to have_content('Invalid Email or password')
      end
    end
    context 'password instructions' do
      it 'failure' do
        userAction(root_path,'ForgotPassword')
        fillIn('ForgotPassword', email)
        expect(page).to have_content('Email not found')
      end
      it 'successfully' do
        old_reset_password_token = user.reset_password_token
        userAction(root_path,'ForgotPassword')
        fillIn('ForgotPassword', user.email)
        expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
        # expect(old_reset_password_token).not_to eq user.reset_password_token
      end

    end
    context 'edit user infomatio' do
      it "successfully" do
        userAction(root_path, 'SignIn')
        fillIn('SignIn', user.email, user.password)
        expect(page).to have_content('Signed in successfully.')
        find(:link, user.email).click
        expect(page).to have_content('Update infomationUser')
        fill_in 'Full name', with: 'Full name'
        fill_in 'Phone', with: '0123123123123'
        fill_in 'Address', with: 'Your address'
        click_on('Update')
        expect(page).to have_content('Your account has been updated successfully.')
      end
    end
  end
end
