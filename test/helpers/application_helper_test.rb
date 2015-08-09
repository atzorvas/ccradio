require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "bootstrap class helper" do
    assert_equal bootstrap_class_for("success"), "alert-success"
    assert_equal bootstrap_class_for("error"), "alert-danger"
    assert_equal bootstrap_class_for("alert"), "alert-warning"
    assert_equal bootstrap_class_for("notice"), "alert-info"
    assert_equal bootstrap_class_for("other"), "other"
  end
end
