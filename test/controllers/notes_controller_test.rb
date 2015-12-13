require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "you can't create a note if you're not logged in" do
    post :create
    assert_response :unauthorized
  end

  test "you can create a note if you're logged in" do
    alice = users(:alice)
    content = 'secret message'
    session[:user_id] = alice.id
    post :create, note: {content: content, visible_to: ''}
    assert_redirected_to '/'
    note = Note.last
    assert note.content == content
    assert note.readers == [alice]
    assert note.user = alice
  end

  test "you can update your own notes" do
    alice, beth = users(:alice), users(:beth)
    session[:user_id] = beth.id

    content = 'oh so secret'
    post :create, note: {content: content, visible_to: ''}
    note_id = Note.last.id
    assert Note.find(note_id).content == content

    new_content = 'a different secret'
    post :update, id: note_id, note: {content: new_content, visible_to: 'alice'}
    assert_redirected_to '/'
    note = Note.find(note_id)
    assert note.content == new_content
    assert note.readers == [alice, beth]
  end
end
