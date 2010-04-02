require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MplayerScreenshot" do
  before(:each) do
    @test_video = File.expand_path(File.dirname(__FILE__) + "/library/test.mp4")
  end
  
  it "should take a screenshot at the 25th second" do
    MPlayer::Screenshoter.new(@test_video, 'mplayer').take(:at => 25, :filename => 'test.png')
    File.exists?('test.png').should be_true
  end
  
  it "should provide a take method through Screenshot module" do
    MPlayer::Screenshot.take(@test_video, :at => 20, :filename => 'test.png')
    File.exists?('test.png').should be_true
  end
  
  it "should raise some errors if :at is missing" do
    lambda {MPlayer::Screenshot.take(@test_video, :filename => 'test.png')}.should raise_error
  end
  
  it "should raise some errors if :filename is missing" do
    lambda {MPlayer::Screenshot.take(@test_video, :at => 4)}.should raise_error
  end
end
