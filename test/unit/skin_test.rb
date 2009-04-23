require 'test_helper'

class SkinTest < ActiveSupport::TestCase
  fixtures :skins
  # Replace this with your real tests.
  def valid_test_skin
    Skin.new :height =>100, :width =>100
  end
  def test_invalid_create
    skin = Skin.new
    assert !skin.valid?
    assert skin.errors.invalid?(:width)
    assert skin.errors.invalid?(:height)
    skin.height=-1
    skin.width=100
    assert !skin.valid?
    assert !skin.errors.invalid?(:width)
    assert skin.errors.invalid?(:height)
    skin.height=10
    skin.width=10001
    assert !skin.valid?
    assert skin.errors.invalid?(:width)
    assert !skin.errors.invalid?(:height)

  end
  def test_create
    
    assert valid_test_skin.valid?
  end
  def test_save
    skin = valid_test_skin
    skin.save
    assert Skin.find(skin.id)
  end
  def test_destroy
    skin = valid_test_skin
    skin.save
    id = skin.id
    skin.destroy
    assert_raise ActiveRecord::RecordNotFound do
      Skin.find(id)
    end
    def test_edit
      skin = valid_test_skin
      skin.save
      id = skin.id
      skin = Skin.find(id)
      skin.width = 99
      skin.height = 88
      skin.save
      skin = Skin.find(id)
      assert_true(skin.width == 99 && skin.height == 88)
    end
  end
end

