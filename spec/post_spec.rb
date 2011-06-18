require './lib/models'
describe 'Posts' do
  it 'should get a unique_id to be edited with' do
    post = Post.new
    post.save
    post.secret_id.should_not be_nil
  end
end


