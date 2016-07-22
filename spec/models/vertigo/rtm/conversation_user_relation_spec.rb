require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe ConversationUserRelation, type: :model do
    subject(:conversation_user_relation) { create(:vertigo_rtm_conversation_user_relation) }

    context 'Associations' do
      it { is_expected.to belong_to(:user).class_name(Vertigo::Rtm.user_class.to_s) }
      it { is_expected.to belong_to(:conversation).counter_cache(:members_count) }
      it { is_expected.to have_one(:preference).class_name('Vertigo::Rtm::Preference').dependent(:destroy) }
    end

    context 'Validations' do
      it { is_expected.to validate_presence_of(:last_read_at) }
    end

    context 'Methods' do
    end
  end
end
