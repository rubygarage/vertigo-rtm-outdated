require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  context 'enums' do
    it { is_expected.to define_enum_for(:vertigo_rtm_status).with([:away, :online, :dnd]) }
  end

  context 'associations' do
    it do
      is_expected.to have_many(:vertigo_rtm_memberships)
        .dependent(:destroy)
        .with_foreign_key(:user_id)
        .class_name('Vertigo::Rtm::Membership')
    end

    it do
      is_expected.to have_many(:vertigo_rtm_conversations)
        .through(:vertigo_rtm_memberships)
        .class_name('Vertigo::Rtm::Conversation')
    end

    it do
      is_expected.to have_many(:vertigo_rtm_own_conversations)
        .with_foreign_key(:creator_id)
        .class_name('Vertigo::Rtm::Conversation')
    end

    it do
      is_expected.to have_many(:vertigo_rtm_groups)
        .class_name('Vertigo::Rtm::Group')
        .through(:vertigo_rtm_memberships)
        .source(:conversation)
    end

    it do
      is_expected.to have_many(:vertigo_rtm_channels)
        .class_name('Vertigo::Rtm::Channel')
        .through(:vertigo_rtm_memberships)
        .source(:conversation)
    end

    it do
      is_expected.to have_one(:vertigo_rtm_preference)
        .class_name('Vertigo::Rtm::Preference')
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:vertigo_rtm_conversation_preferences)
        .class_name('Vertigo::Rtm::Preference')
        .through(:vertigo_rtm_memberships)
    end

    it do
      is_expected.to have_many(:vertigo_rtm_messages)
        .dependent(:destroy)
        .with_foreign_key(:user_id)
        .class_name('Vertigo::Rtm::Message')
    end

    it do
      is_expected.to have_many(:vertigo_rtm_attachments)
        .class_name('Vertigo::Rtm::Attachment')
        .through(:vertigo_rtm_messages)
    end
  end

  context 'validations' do
  end

  context 'methods' do
  end
end
