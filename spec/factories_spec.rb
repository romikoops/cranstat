require 'rails_helper'

RSpec.describe 'Factory Girl' do
  FactoryGirl.factories.each do |factory|
    next if [].include?(factory.name)
    next if factory.name.to_s.include?('abstract_')

    describe "#{factory.name} factory" do
      # Test each factory
      it 'is valid' do
        object = FactoryGirl.build(factory.name)
        if object.respond_to?(:valid?)
          expect(object).to(be_valid, -> { object.errors.full_messages.join("\n") })
        end
      end

      # Test each trait
      factory.definition.defined_traits.map(&:name).each do |trait_name|
        context "with trait #{trait_name}" do
          it 'is valid' do
            object = FactoryGirl.build(factory.name, trait_name)
            if object.respond_to?(:valid?)
              expect(object).to(be_valid, -> { object.errors.full_messages.join("\n") })
            end
          end
        end
      end
    end
  end
end
