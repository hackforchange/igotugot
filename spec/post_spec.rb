require './lib/models'

describe 'Posts' do
  it 'should get a unique_id to be edited with' do
    post = Post.new
    post.save
    post.secret_id.should_not be_nil
  end
end

describe 'Tagging Posts' do
  before(:all) do
   Tag.destroy_all
   Post.destroy_all
   User.destroy_all
  end
  it 'should like, tag a post or something' do
    tag = Tag.create(:name => 'tagged')
    user = User.create
    post = Post.create
    post.taggings.create(:tag => tag, :user => user)
    post.tags.first.should == tag
    post.taggings.first.user.should == user
 end
end


