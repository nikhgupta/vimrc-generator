module VimRCG
  module Utility
    def from_csv(str)
      str.split(/(?:,|\s+)/).reject(&:empty?)
    end
  end
end
