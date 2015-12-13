require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  def setup
    @note = Note.new
    @note.visible_to = 'alice, beth'
  end
  
  test "visible_to= takes a comma separated list of names and makes them readers" do
    assert @note.readers == [users(:alice), users(:beth)]
  end

  test "visible_to returns reader names as a comma-separated string" do
    assert @note.visible_to == 'alice, beth'
  end
end
