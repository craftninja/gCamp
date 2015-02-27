def login(user = create_user)
  visit signin_path
  within '.well' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign In'
  end
end
