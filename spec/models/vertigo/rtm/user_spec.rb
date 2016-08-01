require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  context 'enums' do
    it { is_expected.to define_enum_for(:vertigo_rtm_status).with([:away, :online, :dnd]) }
  end

  context 'associations' do
    it do
      is_expected.to have_many(:conversation_user_relations)
        .dependent(:destroy)
        .with_foreign_key(:user_id)
        .class_name('Vertigo::Rtm::ConversationUserRelation')
    end

    it do
      is_expected.to have_many(:conversations)
        .through(:conversation_user_relations)
        .class_name('Vertigo::Rtm::Conversation')
    end

    it do
      is_expected.to have_many(:own_conversations)
        .with_foreign_key(:creator_id)
        .class_name('Vertigo::Rtm::Conversation')
    end

    it do
      is_expected.to have_many(:groups)
        .class_name('Vertigo::Rtm::Group')
        .through(:conversation_user_relations)
        .source(:conversation)
    end

    it do
      is_expected.to have_many(:channels)
        .class_name('Vertigo::Rtm::Channel')
        .through(:conversation_user_relations)
        .source(:conversation)
    end

    it do
      is_expected.to have_one(:preference)
        .class_name('Vertigo::Rtm::Preference')
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:conversation_preferences)
        .class_name('Vertigo::Rtm::Preference')
        .through(:conversation_user_relations)
    end

    it do
      is_expected.to have_many(:messages)
        .dependent(:destroy)
        .with_foreign_key(:user_id)
        .class_name('Vertigo::Rtm::Message')
    end

    it do
      is_expected.to have_many(:attachments)
        .class_name('Vertigo::Rtm::Attachment')
        .through(:messages)
    end
  end

  context 'validations' do
  end

  context 'methods' do
  end
end
