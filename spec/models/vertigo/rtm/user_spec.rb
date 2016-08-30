require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  context 'enums' do
    it { is_expected.to define_enum_for(:vertigo_rtm_status).with([:offline, :away, :online, :dnd]) }
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
        .source(:conversation)
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
        .source(:preference)
    end

    it do
      is_expected.to have_many(:vertigo_rtm_messages)
        .dependent(:destroy)
        .with_foreign_key(:creator_id)
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
    context '#vertigo_rtm_preference' do
      context 'when preference does not exist' do
        it 'creates preference' do
          expect { subject.vertigo_rtm_preference }.to change { Vertigo::Rtm::Preference.count }.from(0).to(1)
        end
      end

      context 'when preferences exist' do
        let!(:preference) { create(:vertigo_rtm_preference, preferenceable: subject) }

        it 'returns preference' do
          expect { subject.vertigo_rtm_preference }.not_to change { Vertigo::Rtm::Preference.count }
        end
      end

      context '#vertigo_rtm_conversation_preference' do
        let(:conversation) { create(:vertigo_rtm_conversation, creator: subject) }

        it 'returns conversation preference' do
          preference = subject.vertigo_rtm_conversation_preference(conversation.id)

          expect(preference).to eq(Vertigo::Rtm::Preference.take)
        end

        it { expect { subject.vertigo_rtm_conversation_preference(0) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end

  context 'scopes' do
    context '#vertigo_rtm_not_offline' do
      let!(:offline) { create(:user, :offline) }
      let!(:away) { create(:user, :away) }
      let!(:dnd) { create(:user, :dnd) }
      let!(:online) { create(:user, :online) }

      it 'returns not offline users' do
        expect(described_class.vertigo_rtm_not_offline).to match_array([away, dnd, online])
      end
    end
  end

  context 'callbacks' do
    context 'after commit' do
      context '#vertigo_rtm_notify_on_status_change' do
        context 'on create' do
          let(:user) { build(:user) }

          it 'queues the job' do
            expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('user.status.changed', kind_of(Numeric))
            user.save
          end

          it 'is called after commit' do
            allow(user).to receive(:vertigo_rtm_notify_on_status_change)

            user.valid?
            expect(user).not_to have_received(:vertigo_rtm_notify_on_status_change)
            user.run_callbacks(:save)
            expect(user).not_to have_received(:vertigo_rtm_notify_on_status_change)
            user.save
            expect(user).to have_received(:vertigo_rtm_notify_on_status_change)
          end
        end

        context 'on update' do
          let(:user) { create(:user) }

          it 'queues the job' do
            expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('user.status.changed', user.id)

            user.online!
          end

          it 'does not queue the job' do
            expect(Vertigo::Rtm::EventJob).not_to receive(:perform_later).with('user.status.changed', user.id)

            user.offline!
          end

          it 'is called after commit' do
            allow(user).to receive(:vertigo_rtm_notify_on_status_change)

            user.valid?
            expect(user).not_to have_received(:vertigo_rtm_notify_on_status_change)
            user.run_callbacks(:save)
            expect(user).not_to have_received(:vertigo_rtm_notify_on_status_change)
            user.save
            expect(user).not_to have_received(:vertigo_rtm_notify_on_status_change)
            user.update(Vertigo::Rtm.user_name_column => Faker::Internet.user_name)
            expect(user).not_to have_received(:vertigo_rtm_notify_on_status_change)
            user.away!
            expect(user).to have_received(:vertigo_rtm_notify_on_status_change)
          end
        end
      end
    end
  end
end
