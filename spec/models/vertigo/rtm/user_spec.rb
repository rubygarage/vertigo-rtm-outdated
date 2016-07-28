require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  context 'associations' do
    it { is_expected.to have_many(:conversation_user_relations).
                        dependent(:destroy).
                        with_foreign_key(:user_id).
                        class_name('Vertigo::Rtm::ConversationUserRelation') }

    it { is_expected.to have_many(:conversations).
                        through(:conversation_user_relations).
                        class_name('Vertigo::Rtm::Conversation') }

    it { is_expected.to have_many(:own_conversations).
                        with_foreign_key(:creator_id).
                        class_name('Vertigo::Rtm::Conversation') }

    it { is_expected.to have_many(:groups).
                        class_name('Vertigo::Rtm::Group').
                        through(:conversation_user_relations).
                        source(:conversation) }

    it { is_expected.to have_many(:channels).
                        class_name('Vertigo::Rtm::Channel').
                        through(:conversation_user_relations).
                        source(:conversation) }

    it { is_expected.to have_one(:preference).
                        class_name('Vertigo::Rtm::Preference').
                        dependent(:destroy) }

    it { is_expected.to have_many(:conversation_preferences).
                        class_name('Vertigo::Rtm::Preference').
                        through(:conversation_user_relations) }

    it { is_expected.to have_many(:messages).
                        dependent(:destroy).
                        with_foreign_key(:user_id).
                        class_name('Vertigo::Rtm::Message') }
  end

  context 'validations' do
  end

  context 'methods' do
  end
end
