require 'spec_helper'
require 'rails_helper'

describe Commit do

	it { should belong_to :user }
	it { should validate_presence_of :sha }
	it { should validate_presence_of :user }
	it { should validate_presence_of :date }

	

end