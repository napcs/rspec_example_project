require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# To create a project
# as a logged in user
# I need to fill in the title
# and I need to fill in the description
# and the created_at date should be nil



describe Project do

  describe "when creating" do
    
    before(:each) do
      @project = Project.new
      @project.valid?
    end
    
    it "should be invalid without a title" do
      @project.errors.on(:title).should include "can't be blank"
    end
    
    it "should be invalid without a description" do
      @project.errors.on(:description).should include "can't be blank"
      
    end
    
    it "should have a nil created_at date by default" do
      @project.completed_at.should be_nil
    end
    
    
  end


end
