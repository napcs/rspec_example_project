require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
integrate_views

  # To create a project
  # as a logged in user
  # I should see the new project page
  # and I need to fill in the title
  # and I need to fill in the description
  # and the created_at date should be nil
  # and when I click "create project" 
  # it should save the project by posting to /projects
  # and it should redirect me to the list of projects.
  
  
  fixtures :users


  describe "when showing projects" do
    
    before(:each) do
      @request.session[:user_id] = users(:quentin).id
    end
    
    it "should render the index template" do
      get :index
      response.should render_template "index"
    end
    
    it "should display five bullets for five projects" do
      
      @projects = []
      %W{one two three four five six seven}.each do |p|
        @projects << Project.new(:title => p)
      end
      
      Project.stubs(:find).returns(@projects)
      get :index
      response.should have_tag "li", :maximum=>5
    end
    
  end

  
  describe "when creating (POST /projects)" do
    
    before(:each) do
      @request.session[:user_id] = users(:quentin).id
    end
  
    
    it "should redirect to the index action when sucessful" do
      Project.any_instance.stubs(:save).returns(true)
      post :create
      response.should redirect_to projects_url
    end
    
    it "should render the new template with the errors display if unsuccessful" do
      Project.any_instance.expects(:save).returns(false)
      post :create
      response.should render_template "new"
    end
    
  end
  
  describe "the new page (GET /projects/new)" do
    
    describe "when not logged in" do
      
      it "should redirect to the login_url" do
        get :new
        response.should redirect_to login_url
      end
    end
    
    describe "when  logged in" do
      before(:each) do
        @request.session[:user_id] = users(:quentin).id
      end
      
      it "should display the new template" do
        get :new
        response.should render_template "new"
      end
      
      
      # projects_url = "http://example.com:3000/projects/"
      # projects_path = "/projects"
      
      it "should have a form that posts to the create action (/projects/create)" do
        get :new
        response.should have_tag "form[method=post][action=?]", projects_path
      end
      
      it "should have a title field scoped to the project (project[title])" do
        get :new
        response.should have_tag "input[type=text][name=?]", "project[title]"
      end

      it "should have a description field scoped to the project (project[description])" do
        get :new
        response.should have_tag "textarea[name=?]", "project[description]"
      end
      
      it "should have a post button called \"Create Project\" " do
        get :new
        response.should have_tag "input[type=submit][value=Create Project]"
      end
    end
    
  end

end
