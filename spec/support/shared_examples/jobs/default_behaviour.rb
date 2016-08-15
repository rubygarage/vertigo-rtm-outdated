RSpec.shared_examples :default_behaviour do
  let(:arguments) { [1, 2, 3] }

  it 'matches with job class name' do
    expect { described_class.perform_later }.to have_enqueued_job(described_class)
  end

  it 'matches with passed arguments to job' do
    expect { described_class.perform_later(arguments) }.to have_enqueued_job.with(arguments)
  end

  it 'matches with enqueued time' do
    expect do
      described_class.set(wait_until: Time.zone.tomorrow.middle_of_day).perform_later
    end.to have_enqueued_job.at(Time.zone.tomorrow.middle_of_day)
  end

  it 'matches with queue name' do
    expect { described_class.perform_later }.to have_enqueued_job.on_queue('default')
  end
end
