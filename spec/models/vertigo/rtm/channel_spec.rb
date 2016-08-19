require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Channel, type: :model do
      subject(:channel) { create(:vertigo_rtm_channel) }

      it_behaves_like :per_page

      context 'enums' do
        it { is_expected.to define_enum_for(:state).with([:unarchived, :archived]) }
      end

      context 'associations' do
        it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to have_many(:memberships).dependent(:destroy).inverse_of(:conversation) }
        it do
          is_expected.to have_many(:members)
            .through(:memberships)
            .class_name(Vertigo::Rtm.user_class.to_s)
            .source(:user)
        end
        it { is_expected.to have_many(:messages).dependent(:destroy) }
      end

      context 'validations' do
        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_uniqueness_of(:name) }
      end

      context 'methods' do
        context '#group?' do
          it { is_expected.not_to be_group }
        end

        context '#channel?' do
          it { is_expected.to be_channel }
        end

        context '#invite!' do
          it 'creates membership' do
            subject
            new_user = create(:user)
            expect { subject.invite!(new_user.id) }.to change { Vertigo::Rtm::Membership.count }.from(1).to(2)
          end
        end

        context '#leave!' do
          it 'deletes membership' do
            user = create(:user)
            subject.memberships.create(user: user)
            expect { subject.leave!(user.id) }.to change { Vertigo::Rtm::Membership.count }.by(-1)
          end
        end

        context '#kick!' do
          it 'deletes membership' do
            user = create(:user)
            subject.memberships.create(user: user)
            expect { subject.kick!(user.id) }.to change { Vertigo::Rtm::Membership.count }.by(-1)
          end
        end

        include_context :changeable_enums
        it_behaves_like :it_has_enums_with_raising_exceptions, :state
      end

      context 'callbacks' do
        let(:user) { create(:user) }

        context 'after commit' do
          context '#ensure_membership' do
            let(:channel) { build(:vertigo_rtm_channel, creator: user) }

            it 'creates user_conversation relation for creator' do
              channel.save

              expect(channel.reload.members_count).to eq(1)
            end

            it 'is called after commit' do
              allow(channel).to receive(:ensure_membership)

              channel.valid?
              expect(channel).not_to have_received(:ensure_membership)
              channel.run_callbacks(:save)
              expect(channel).not_to have_received(:ensure_membership)
              channel.save
              expect(channel).to have_received(:ensure_membership)
            end
          end

          context '#notify_on_create' do
            let!(:channel) { build(:vertigo_rtm_channel, creator: user) }

            it 'queues the job' do
              expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('channel.created', kind_of(Numeric))
              channel.save
            end

            it 'is called after commit' do
              allow(channel).to receive(:notify_on_create)

              channel.valid?
              expect(channel).not_to have_received(:notify_on_create)
              channel.run_callbacks(:save)
              expect(channel).not_to have_received(:notify_on_create)
              channel.save
              expect(channel).to have_received(:notify_on_create)
            end
          end

          context '#notify_on_rename' do
            it 'queues the job' do
              expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('channel.renamed', subject.id)
              subject.update(name: Faker::Team.name)
            end

            it 'is called after commit if name previously changed' do
              allow(subject).to receive(:notify_on_rename)

              subject.valid?
              expect(subject).not_to have_received(:notify_on_rename)
              subject.run_callbacks(:save)
              expect(subject).not_to have_received(:notify_on_rename)
              subject.save
              expect(subject).not_to have_received(:notify_on_rename)
              subject.update(name: Faker::Team.name)
              expect(subject).to have_received(:notify_on_rename)
            end
          end

          context '#notify_on_status_change' do
            described_class.states.each_key do |state|
              let(:new_state) { (described_class.states.keys - [subject.state]).sample }

              context "on #{state}" do
                it 'queues the job' do
                  expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with("channel.#{new_state}", subject.id)
                  subject.send("#{new_state}!")
                end

                it 'is called after commit if state previously changed' do
                  allow(subject).to receive(:notify_on_status_change)

                  subject.valid?
                  expect(subject).not_to have_received(:notify_on_status_change)
                  subject.run_callbacks(:save)
                  expect(subject).not_to have_received(:notify_on_status_change)
                  subject.save
                  expect(subject).not_to have_received(:notify_on_status_change)
                  subject.send("#{new_state}!")
                  expect(subject).to have_received(:notify_on_status_change)
                end
              end
            end
          end
        end

        context 'after invite' do
          it 'queues the job' do
            user
            expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('channel.joined', subject.id)
            subject.invite!(user.id)
          end

          it 'is called after invite' do
            allow(subject).to receive(:notify_on_invite)

            subject.valid?
            expect(subject).not_to have_received(:notify_on_invite)
            subject.run_callbacks(:save)
            expect(subject).not_to have_received(:notify_on_invite)
            subject.save
            expect(subject).not_to have_received(:notify_on_invite)
            subject.update(name: Faker::Team.name)
            expect(subject).not_to have_received(:notify_on_invite)
            subject.invite!(user.id)
            expect(subject).to have_received(:notify_on_invite)
          end
        end

        context 'after leave' do
          it 'queues the job' do
            subject.memberships.create(user: user)
            expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('channel.left', subject.id)
            subject.leave!(user.id)
          end

          it 'is called after leave' do
            allow(subject).to receive(:notify_on_leave)

            subject.valid?
            expect(subject).not_to have_received(:notify_on_leave)
            subject.run_callbacks(:save)
            expect(subject).not_to have_received(:notify_on_leave)
            subject.save
            expect(subject).not_to have_received(:notify_on_leave)
            subject.update(name: Faker::Team.name)
            expect(subject).not_to have_received(:notify_on_leave)
            subject.invite!(user.id)
            expect(subject).to_not have_received(:notify_on_leave)
            subject.leave!(user.id)
            expect(subject).to have_received(:notify_on_leave)
          end
        end

        context 'after kick' do
          it 'queues the job' do
            subject.memberships.create(user: user)

            expect(Vertigo::Rtm::EventJob).to receive(:perform_later).with('channel.kicked', subject.id)
            subject.kick!(user.id)
          end

          it 'is called after kick' do
            allow(subject).to receive(:notify_on_kick)

            subject.valid?
            expect(subject).not_to have_received(:notify_on_kick)
            subject.run_callbacks(:save)
            expect(subject).not_to have_received(:notify_on_kick)
            subject.save
            expect(subject).not_to have_received(:notify_on_kick)
            subject.update(name: Faker::Team.name)
            expect(subject).not_to have_received(:notify_on_kick)
            subject.invite!(user.id)
            expect(subject).to_not have_received(:notify_on_kick)

            subject.kick!(user.id)
            expect(subject).to have_received(:notify_on_kick)
          end
        end
      end
    end
  end
end
