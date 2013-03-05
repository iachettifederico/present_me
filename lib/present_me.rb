# -*- coding: utf-8 -*-
require_relative "present_me/version"
require_relative "present_me/string_box"


module Kernel
  alias old_puts puts

  def ¡present(*args)
    show_console_output
    old_puts(*args)
  end

  def puts(*args)
    show_console_output
    c = caller.last.split(':')
    args << nil if args.count == 0
    args.each do |arg|
      old_puts("[#{c[1]}] #{arg}")
    end
    args.count == 1 ? args.first : args
  end

  def ¡space(n=1)
    n.times { ¡present }
  end
  
  def ¡box(content, style=:simple)
    ¡present StringBox.new(content, style).call #.each do |line|
  end

  def show_console_output
    unless defined? @output
      old_puts StringBox.new("Console Output", :double).call
      old_puts
    end
    @output = true
  end

  alias old_method_missing method_missing
  def method_missing(method, *args, &block)
    if /¡¡.*/ === method.to_s
      #no-op
    elsif /¡.*/ === method.to_s and !args.empty?
      define_singleton_method(method) do
        args.join(' ')
      end

      args.join(' ')
    else
      old_method_missing(method, *args, &block)
    end
  end
end
#Object.send( :include, PresentMe)
