require 'test_helper'

class User < ActiveRecord::Base
  raw_attribute :title
end

class Profile < ActiveRecord::Base  
  raw_attribute :all
end

class Person < ActiveRecord::Base  
  raw_attribute :all, :except => [:title]
end

class RawAttributeTest < ActiveSupport::TestCase
  test "html will render as raw when attribute specified" do
    User.create(:title => "<script>title</script>", :address => "<script>address</script>")
    user = User.first

    assert user.title.is_a?(ActiveSupport::SafeBuffer)
    assert user.address.is_a?(String)
  end
  
  test "html will render as raw when all attribute specified" do
    Profile.create(:title => "<script>title</script>", :address => "<script>address</script>")
    profile = Profile.first

    assert profile.title.is_a?(ActiveSupport::SafeBuffer)
    assert profile.address.is_a?(ActiveSupport::SafeBuffer)
  end
  
  test "html will render as raw when except attribute specified" do
    Person.create(:title => "<script>title</script>", :address => "<script>address</script>")
    person = Person.first
    
    assert person.title.is_a?(String)
    assert person.address.is_a?(ActiveSupport::SafeBuffer)
  end
end


