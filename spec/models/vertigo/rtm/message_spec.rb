require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Message, type: :model do
      subject(:message) { create(:vertigo_rtm_message) }

      it_behaves_like :per_page

      context 'associations' do
        it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to belong_to(:conversation).counter_cache(true) }
        it { is_expected.to have_many(:attachments).dependent(:destroy) }
      end

      context 'validations' do
      end

      context 'methods' do
      end

      context 'scopes' do
        context '#unread_by' do
          let(:conversation) { create(:vertigo_rtm_conversation) }
          let!(:odd_message) do
            create(:vertigo_rtm_message, created_at: 2.days.ago)
          end
          let!(:old_message) do
            create(:vertigo_rtm_message, created_at: 4.days.ago, conversation: conversation)
          end
          let!(:new_message) do
            create(:vertigo_rtm_message, created_at: 2.days.ago, conversation: conversation)
          end
          let(:user) { create(:user) }

          before do
            membership = create(:vertigo_rtm_membership,
                                user: user,
                                conversation: conversation)
            membership.update_column(:last_read_at, 3.days.ago)
          end

          it 'returns messages not read by user' do
            expect(conversation.messages.unread_by(user.id)).to eq([new_message])
          end
        end
      end

      context 'callbacks' do
        context 'after commit' do
          context '#notify_on_create' do
            let!(:user) { create(:user) }
            let!(:conversation) { create(:vertigo_rtm_conversation) }
            let(:message) { build(:vertigo_rtm_message, creator: user, conversation: conversation) }

            it 'queues the job' do
              expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('message.created', kind_of(Numeric))

              message.save
            end

            it 'is called after commit on create' do
              allow(message).to receive(:notify_on_create)

              message.valid?
              expect(message).not_to have_received(:notify_on_create)
              message.run_callbacks(:save)
              expect(message).not_to have_received(:notify_on_create)
              message.save
              expect(message).to have_received(:notify_on_create)
            end
          end

          context '#notify_on_update' do
            let!(:user) { create(:user) }
            let!(:conversation) { create(:vertigo_rtm_conversation) }
            let!(:message) { create(:vertigo_rtm_message, creator: user, conversation: conversation) }

            it 'queues the job' do
              expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('message.updated', message.id)

              message.update(text: Faker::Lorem.sentence)
            end

            it 'is called after commit on update' do
              new_message = build(:vertigo_rtm_message, creator: user, conversation: conversation)

              allow(new_message).to receive(:notify_on_update)

              new_message.valid?
              expect(new_message).not_to have_received(:notify_on_update)
              new_message.run_callbacks(:save)
              expect(new_message).not_to have_received(:notify_on_update)
              new_message.save
              expect(new_message).not_to have_received(:notify_on_update)
              new_message.update(text: Faker::Lorem.sentence)
              expect(new_message).to have_received(:notify_on_update)
            end
          end

          context '#notify_on_delete' do
            let!(:user) { create(:user) }
            let!(:conversation) { create(:vertigo_rtm_conversation) }
            let!(:message) { create(:vertigo_rtm_message, creator: user, conversation: conversation) }

            it 'queues the job' do
              expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('message.deleted', message.id)

              message.destroy
            end

            it 'is called after commit on delete' do
              new_message = build(:vertigo_rtm_message, creator: user, conversation: conversation)

              allow(new_message).to receive(:notify_on_delete)

              new_message.valid?
              expect(new_message).not_to have_received(:notify_on_delete)
              new_message.run_callbacks(:save)
              expect(new_message).not_to have_received(:notify_on_delete)
              new_message.save
              expect(new_message).not_to have_received(:notify_on_delete)
              new_message.update(text: Faker::Lorem.sentence)
              expect(new_message).not_to have_received(:notify_on_delete)

              new_message.destroy
              expect(new_message).to have_received(:notify_on_delete)
            end
          end
        end
      end
    end
  end
end
