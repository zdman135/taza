require 'rake'
require 'rubygems'
require 'need'
need { 'spec_helper' }
need { '../lib/generators/site_generator' }
need { '../lib/generators/page_generator' }

describe "generation tasks" do
  
  before :all do
    @file_name ="./lib/tasks/taza_tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
    load @file_name     
  end
  
  it "should create a site file in lib/sites" do
    SiteGenerator.any_instance.expects(:file).with('site.rb.erb','lib/sites/foo.rb')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo/flows')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo/pages')
    ENV['name'] = 'foo'
    @rake.invoke_task("generate:site")
  end

  it "should create a page file in lib/sites" do
    PageGenerator.any_instance.expects(:file).with('page.rb.erb','lib/sites/ecom/pages/home.rb')
    ENV['site'] = 'ecom'
    ENV['name'] = 'home'
    @rake.invoke_task("generate:page")
  end
  
end
