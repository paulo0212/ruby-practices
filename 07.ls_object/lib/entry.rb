# frozen_string_literal: true

require 'etc'

class Entry
  attr_reader :pathname, :name

  def initialize(path)
    @pathname = Pathname.new(path)
    @name = File.basename(path)
    @stat = File::Stat.new(@pathname)
  end

  def mode
    @stat.mode
  end

  def nlink
    @stat.nlink
  end

  def owner
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def size
    @stat.size
  end

  def mtime
    @stat.mtime
  end

  def blocks
    @stat.blocks
  end

  def directory?
    @pathname.directory?
  end
end
