require 'helper'
require 'models/user'

class MetabolicalTest < Test::Unit::TestCase
  context "an ActiveRecord Object" do

    context "new record" do
      setup do
        @user = User.new
      end
      
      teardown do
        @user.destroy
      end
      
      should "be able to assign a single meta before saving and retrieving it after save" do
        @user.metas['foo'] = 'bar'
        @user.save
        assert_equal 'bar', @user.metas['foo'].data
      end
      
      should "be able to assign a single meta before saving and retrieving it before save" do
        @user.metas['foo'] = 'bar'
        assert_equal 'bar', @user.metas['foo'].data
      end
    end
    
    context "saved record" do
      setup do
        @user = User.new
        @user.save
      end
      
      teardown do
        @user.destroy
      end
      
      should "be able to assign a single meta before re saving and retrieving it after save" do
        @user.metas['foo'] = 'bar'
        @user.save
        assert_equal 'bar', @user.metas['foo'].data
      end
      
      should "be able to assign a single meta before re saving and retrieving it before save" do
        @user.metas['foo'] = 'baz'
        assert_equal 'baz', @user.metas['foo'].data
      end
      
      should "be able to retrieve after saving" do
        @user.metas['foo'] = 'faz'
        @user.save
        user = User.find @user.id
        assert_equal 'faz', user.metas['foo'].data
      end
      
    end
    
    context "named scopes" do
      setup do
        @foo_user = User.create(:name => 'foo_user', :metas => [Metabolical::MetaDatum.new(:key => "foo", :data => "bar")])
        @bar_user = User.create(:name => 'bar_user', 
                                :metas => [Metabolical::MetaDatum.new(:key => "bar", :data => "baz"),
                                           Metabolical::MetaDatum.new(:key => "fuu", :data => "bar")])
        @true_user = User.create(:name => 'true_user', :metas => [Metabolical::MetaDatum.new(:key => "bar", :data => true)])
      end
      
      teardown do
        User.delete_all
      end
      
      should "have with_meta scopes" do
        assert_equal [@foo_user], User.with_meta("foo")
        assert_equal [@bar_user, @true_user], User.with_meta("bar")
      end
      
      should "have with_meta scopes that check for data" do
        assert_equal [], User.with_meta_data("foo", "foo")
        assert_equal [@foo_user], User.with_meta_data("foo", "bar"), "Should have brought back foo user"
        assert_equal [@true_user], User.with_meta_data("bar", true), "Should have brought back true user"
      end
      
      should "have with_metas scope that includes all metas" do
        assert User.respond_to?(:with_metas)
      end
      
      should "bring back objects without a certain meta" do
        assert_equal [@foo_user], User.without_meta("bar")
      end
      
    end
  end
end