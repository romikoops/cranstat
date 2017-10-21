require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#full_name' do
    context 'when email present' do
      let(:user) { create(:user, name: 'SuperMario', email: 'super@mario.com') }
      it { expect(user.full_name).to eq('SuperMario (super@mario.com)') }
    end

    context 'when email blank' do
      let(:user) { create(:user, name: 'SuperMario', email: '') }
      it { expect(user.full_name).to eq('SuperMario') }
    end
  end
end
