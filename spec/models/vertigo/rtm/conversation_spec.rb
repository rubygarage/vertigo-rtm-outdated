require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe Conversation, type: :model do
    subject(:conversation) { create(:vertigo_rtm_conversation) }

    context 'Associations' do
      it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
      it { is_expected.to have_many(:conversation_user_relations).dependent(:destroy) }
      it { is_expected.to have_many(:members).through(:conversation_user_relations).class_name(Vertigo::Rtm.user_class.to_s) }
      it { is_expected.to have_many(:messages).dependent(:destroy) }
    end

    context 'Validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to define_enum_for(:status).with([:unarchive, :archive])}
    end

    context 'Methods' do
      context '#group?' do
        it { is_expected.not_to be_group }
      end

      context '#channel?' do
        it { is_expected.not_to be_channel }
      end
    end
  end
end
