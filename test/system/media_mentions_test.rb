require "application_system_test_case"

class MediaMentionsTest < ApplicationSystemTestCase
  setup do
    @media_mention = media_mentions(:one)
  end

  test "visiting the index" do
    visit media_mentions_url
    assert_selector "h1", text: "Media mentions"
  end

  test "should create media mention" do
    visit media_mentions_url
    click_on "New media mention"

    fill_in "Link", with: @media_mention.link
    fill_in "Name", with: @media_mention.name
    fill_in "Organization name", with: @media_mention.organization_name
    fill_in "Published date", with: @media_mention.published_date
    click_on "Create Media mention"

    assert_text "Media mention was successfully created"
    click_on "Back"
  end

  test "should update Media mention" do
    visit media_mention_url(@media_mention)
    click_on "Edit this media mention", match: :first

    fill_in "Link", with: @media_mention.link
    fill_in "Name", with: @media_mention.name
    fill_in "Organization name", with: @media_mention.organization_name
    fill_in "Published date", with: @media_mention.published_date
    click_on "Update Media mention"

    assert_text "Media mention was successfully updated"
    click_on "Back"
  end

  test "should destroy Media mention" do
    visit media_mention_url(@media_mention)
    click_on "Destroy this media mention", match: :first

    assert_text "Media mention was successfully destroyed"
  end
end
