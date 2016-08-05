RSpec.shared_context :changeable_enums do
  RSpec.shared_examples :it_has_enums_with_raising_exceptions do |enum_key|
    let(:enum_keys) { described_class.public_send(enum_key.to_s.pluralize).keys }
    let(:init_enum_key) { enum_keys.sample }
    let(:other_enum_key) { (enum_keys - [init_enum_key]).sample }

    before { subject.update_column(enum_key, init_enum_key) }

    context "#{enum_key} is set to different value" do
      it 'changes state' do
        subject.public_send("#{other_enum_key}!")

        expect(subject.public_send("#{other_enum_key}?")).to be true
      end
    end

    context "#{enum_key} is set to the same value" do
      it 'raises error on same state' do
        expect { subject.public_send("#{init_enum_key}!") }.to raise_error(
          ActiveRecord::RecordInvalid
        )
        expect(subject.errors[enum_key]).to include(
          I18n.t(:has_been_already_state,
                 state: init_enum_key,
                 scope: 'vertigo.rtm.errors')
        )
        expect(subject.public_send("#{init_enum_key}?")).to be true
      end
    end
  end
end
