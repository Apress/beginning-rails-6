require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = articles(:welcome_to_rails)
    @user = users(:eugene)
  end

  def sign_in(user)
    visit login_url

    fill_in "email", with: user.email
    fill_in "password", with: 'secret'

    click_button "Login"
  end

  def fill_in_rich_text(locator, content)
    find(locator).base.send_keys(content)
  end

  def set_datetime_select(locator, datetime)
    select datetime.strftime("%Y"),  from: "#{locator}_1i" # Year
    select datetime.strftime("%B"),  from: "#{locator}_2i" # Month
    select datetime.strftime("%-d"), from: "#{locator}_3i" # Day
    select datetime.strftime("%H"),  from: "#{locator}_4i" # Hour
    select datetime.strftime("%M"),  from: "#{locator}_5i" # Minutes
  end

  test "visiting the index" do
    visit articles_url
    assert_selector "h1", text: "Articles"
  end

  test "creating a Article" do
    sign_in(@user)

    visit articles_url
    click_on "New Article"

    fill_in_rich_text("#article_body", @article.body)
    fill_in "Excerpt", with: @article.excerpt
    fill_in "Location", with: @article.location
    set_datetime_select("article_published_at", @article.published_at)
    fill_in "Title", with: @article.title
    click_on "Create Article"

    assert_text "Article was successfully created"
  end

  test "updating a Article" do
    sign_in(@user)

    visit articles_url

    find(".article a", match: :first).hover
    find(".article .actions a", text: "Edit").click

    fill_in_rich_text("#article_body", @article.body)
    fill_in "Excerpt", with: @article.excerpt
    fill_in "Location", with: @article.location
    set_datetime_select("article_published_at", @article.published_at)
    fill_in "Title", with: @article.title
    click_on "Update Article"

    assert_text "Article was successfully updated"
  end

  test "destroying a Article" do
    sign_in(@user)

    visit articles_url

    find(".article a", match: :first).hover

    find(".article .actions a", text: "Delete").click

    assert_text "Article was successfully destroyed"
  end
end
