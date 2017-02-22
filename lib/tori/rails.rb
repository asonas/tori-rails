require 'tori'
require 'tori/rails/callback'
require 'tori/rails/define'
require 'tori/rails/error'
require 'tori/rails/registerable'
require "tori/rails/version"

::ActiveRecord::Base.extend(Tori::Define)
