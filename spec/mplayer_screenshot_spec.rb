require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MplayerScreenshot" do
  before(:each) do
    @test_video = File.expand_path(File.dirname(__FILE__) + "/library/test.mp4")
  end
  
  it "should take a screenshot at the 25th second" do
    MPlayer::Screenshoter.new(@test_video).take(:at => 25, :filename => 'test.png')
    File.exists?('test.png').should be_true
  end
end
