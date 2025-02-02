require "test_helper"

class MediaMentionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @media_mention = media_mentions(:one)
  end

  test "should get index" do
    get media_mentions_url
    assert_response :success
  end

  test "should get new" do
    get new_media_mention_url
    assert_response :success
  end

  test "should create media_mention" do
    assert_difference("MediaMention.count") do
      post media_mentions_url, params: { media_mention: { link: @media_mention.link, name: @media_mention.name, organization_name: @media_mention.organization_name, published_date: @media_mention.published_date } }
    end

    assert_redirected_to media_mention_url(MediaMention.last)
  end

  test "should show media_mention" do
    get media_mention_url(@media_mention)
    assert_response :success
  end

  test "should get edit" do
    get edit_media_mention_url(@media_mention)
    assert_response :success
  end

  test "should update media_mention" do
    patch media_mention_url(@media_mention), params: { media_mention: { link: @media_mention.link, name: @media_mention.name, organization_name: @media_mention.organization_name, published_date: @media_mention.published_date } }
    assert_redirected_to media_mention_url(@media_mention)
  end

  test "should destroy media_mention" do
    assert_difference("MediaMention.count", -1) do
      delete media_mention_url(@media_mention)
    end

    assert_redirected_to media_mentions_url
  end
end
