require 'ftools'

module MPlayer
  module Screenshot
    extend self
    
    def take(opts={})
      
    end
  end
  
  class Screenshoter
    def initialize(file, mplayer_cmd='mplayer')
      @file = file
      @mplayer_cmd = mplayer_cmd
    end
    
    def take(opts={})
      @opts = opts.dup
      normalize_path
      Dir.chdir '/tmp' do 
        mplayer :frames  => 1, 
                :vo      => 'png', 
                :nosound => "",
                :ss      => opts[:at]
        clean
      end
      
    end
    
    def normalize_path
      @opts[:filename] = File.expand_path @opts[:filename]
    end
    
    # Delete all png generated files excepted the wanted one which 
    # will be moved to where you specified. 
    # Usually, there should be only one file, "0000001.png", 
    # but if something goes wrong, many files could be created, 
    # eating your freespace with tons of pngs, let's avoid this.
    def clean
      frames = Dir.glob('[0-9]*.png')
      frames.each do |file|
        File.delete(file) unless file == frames[-1]
      end
      
      File.copy frames[-1], @opts[:filename]
      File.delete frames[-1]
    end
    
    def mplayer(opts={})
      log = ""
      
      IO.popen("#{@mplayer_cmd} #{serialize_arguments(opts)} #{@file}") do |out|
        out.each_line { |line| log << line }
      end
      
      log
    end
    
    def serialize_arguments(opts={})
      str = ""
      
      opts.each do |k,v|
        str << "-#{k} #{v} "
      end
      
      str
    end
  end
end
